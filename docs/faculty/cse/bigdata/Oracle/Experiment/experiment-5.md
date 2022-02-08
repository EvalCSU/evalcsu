# 实验五、综合实验

## 一、目的与要求

本实验为综合实验，要求综合运用用户管理、逻辑备份、访问数据字典等技术解决问题。

## 二、操作环境

- 硬件：主频2GHz以上服务器（内存2GB以上、硬件空闲2.2GB以上），主频1GHz以上微机，内存1GB以上。
- 软件：WINDOWS XP/2000/2003/或Win7/Win8/Win10等。如操作系统是 SERVER版， 可安装ORACLE/9i/10g/11g/12C FOR NT/WINDOWS(注意有32位与64位的区别，可选企业版)； 如果Windows非server如XP/win7等，安装时请选择个人版(PERSONAL)，注意安装时要有兼容性设置与用管理员运行。安装过程中需要关注系统预定义的账号SYS与SYSTEM的密码设置。

## 三、实验内容

### 1. 创建 PROFILE 文件

创建一个 PROFILE 文件 pTester ，设置锁定用户的登录失败次数为 3 次，会话的总计连接时间 60 分钟，口令可用天数 30 天

```plsql
sqlplus SYSTEM/sys
grant create profile to C##U_LZC_D312;
conn C##U_LZC_D312/sys;
drop profile C##pTester;
create profile C##pTester
	LIMIT FAILED_LOGIN_ATTEMPTS 3
	CONNECT_TIME 60
	PASSWORD_LOCK_TIME 30;
```

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111230819090.png" alt="image-20211123081902916" style="zoom:67%;" />

### 2. 使用 PROFILE

创建一个新用户 Tester ，密码为 Tester123 ，缺省表空间是 tabspace\_???? 。在 tabspace_???? 表空间中可以使用 50M 空间，指定环境资源文件为 pTester 。

使用 create user 命令创建用户，利用可选参数 DEFAULT TABLESPACE 指定表空间，QUOTA 50M on tabspace_D311 指定在表空间中可以使用的大小，PROFILE指定资源环境文件。

```plsql
-- 激活资源限制
sqlplus SYSTEM/sys
alter system set resource_limit=true;

conn C##U_LZC_D312/sys;
drop user C##Tester;
create user C##Tester identified by Tester123
	default tablespace tabspace_D312
	quota 50M on tabspace_D312
	profile C##pTester;
```

注意：要使 PROFILE 文件生效，应先激活 `resource_limit` 。

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111230829771.png" alt="image-20211123082918627" style="zoom:67%;" />

### 3. 将角色 RESOURCE 指派给用户 Tester

```plsql
grant resource to C##Tester;
-- grant connect, resource, dba to C##Tester;
```

### 4. 导入表

```plsql
exp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\major.dmp tables=(t_major_D312)

conn C##Tester/Tester123;
drop table t_major_D312;

imp C##Tester/Tester123 file=E:\App\Lemonade\oradata\backuptest\major.dmp tables=(t_major_D312)
```

注意导入时出现这种错误：oracle 导入DMP文件时IMP-00013: 只有 DBA 才能导入由其他 DBA 导出的文件 IMP-00000: 未成功终止导入

解决办法：法一把导出的用户 DBA 权限去掉，重新导出；法二是给要导入的用户加上 DBA 权限。这里选择法二

```plsql
col majorno format a8;
col mname format a8;
col loc format a8;
col mdean format a8;
col majorno format a8;
col SUM_EVALUATION for 9999

select * from t_major_D312;
```

![image-20211123085006900](C:/Users/Lenovo/AppData/Roaming/Typora/typora-user-images/image-20211123085006900.png)

### 5. 实现逻辑导出

利用 PL/SQL 语言，编写一个存储过程实现针对单张表的逻辑数据导出功能，要求将给定表的数据转换成 SQL 语言的 Insert 语句，表的结构转换成 SQL 语言的 Create Table 语句，并保存在文件中。该过程以要导出的表名和保存 SQL 语句的文件名为参数，可以以 major_???? 表为例进行测试

**这里为覆盖到所有功能（创建，约束，默认值，插入），使用 `t_stud` 表进行测试**

#### 1. 借鉴 Oracle

首先查看原本导出的数据 Oracle 是如何存储的，即先导出`t_stud_D312` 表后查看 `t_stud.dmp` 文件内容

```plsql
exp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\t_stud.dmp tables=(t_stud2_info_D312)
```

但由于直接打开会出现下面这张乱码情况

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111232139568.png" alt="image-20211123213931463" style="zoom:67%;" />

所以我们利用 `imp` 的导出日志，将其存储然后再查看

```plsql
imp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\major.dmp show=y log=abcd_log.log full=y
```

内容如下

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111232140533.png" alt="image-20211123214038452" style="zoom:67%;" />

于是就可以借鉴 Oracle 原生导出后的样例进行我们的 Coding

#### 2. 预处理

在这里我们事先定义好导出的目录并授权给用户 `C##U_LZC_D312`

```plsql
create or replace  directory D_OUTPUT  as 'E:/App/Lemonade/oradata/backuptest/' ;
grant read, write on directory D_OUTPUT  to C##U_LZC_D312;
```

为下面方便进行，我们这里定义两个辅助表

```plsql
conn C##U_LZC_D312/sys;

drop t_table_details;
create table t_table_details(
    table_name varchar(256),
    col_name varchar(256),
    col_type varchar(32),
    col_size number
);

drop table t_fields;
create table t_fields(
	field varchar2(256)
);
```

其中

- `t_table_details` 表用来存储一些关于表的元数据信息，用于后续 `create` 语句的生成
- `t_fields` 表用来存储一些字段的值，用于后续 `insert` 语句的快速生成（借助正则）

#### 3. 步骤

1. 生成 `create` 语句
   1. 读取 `user_tab_cols` 数据字典获得表的元信息
   2. 遍历`t_table_details` 生成 `create` 语句
2. 生成 `constraint` 并设置 `state`
   1. 读取`dba_cons_columns`与`dba_constraints` 获取该表的所有约束
   2. 对这些约束分`C` `P` `U` `R` 四种类型分别生成语句（其中对于`R`类型，即外键，需要额外使用`user_cons_columns` 与 `user_constraints` 数据字典来获得外键所在的表以及列名）
   3. 激活约束
   4. 默认值约束语句生成
      1. 读取 `dba_tab_columns` 数据字典获得有默认值列以及默认值
      2. 隐式游标遍历上述信息生成相应语句
3. 生成 `insert` 语句
   1. 通过 `col` 读取该表的列的元数据信息
   2. 生成动态 SQL 语句
   3. `open-for` 执行动态 SQL 语句（注意，此处额外实现一个 `fix_field` 函数，用于处理一些 `insert` 过程中的相关细节问题，例如引号问题，`DATE` 格式问题）



```plsql
set serveroutpu on;
set linesize 500;
create or replace procedure p_exp_manual_D312 (p_table_name in varchar2, p_file_path in varchar2 default 'test.txt') 
as
	-- 目标文件
	v_out_file UTL_FILE.FILE_TYPE;
	-- 要写入到目标文件的字符串
	v_file_buf varchar2(32767);
    -- 记录用户名
    v_username varchar2(32);
    
    
    -- 约束内容
    v_cons_head varchar2(256);
    v_cons varchar2(256);
    v_cons_state varchar2(32);
    v_set_cons_state varchar2(256);
    -- 被引用为外键的列
    v_rcol varchar2(256);
    -- 被引用外键的表
    v_rtable_name varchar2(256);
    
    -- 存储默认值
    v_default_head varchar2(256);
    v_default varchar2(256);
    
    
    -- insert 内容
    -- MAJORNO||','||MNAME||','||LOC||','||MDEAN||','||SUM_EVALUATION
	v_fields varchar2(4096); 
	-- select 'insert into t_major_D312 values(' || 上面的fields || ')' from t_major_D312
	v_sql varchar2(4096);  
	 
	type curType is ref cursor;  
	cur_sql curType;
	-- 执行 v_sql 后的每一行，比如 insert into t_major_D312 values(00,计科,主校区,王斌,1000)
	v_row varchar2(4096); 
	-- v_row中'('之前的部分
	v_ldata varchar2(32765);
    -- v_row中'()'之间的部分
    v_rdata varchar2(32765);  
    -- 第几列
    v_cnt number(10);  
    -- 记录左右括号的位置
    v_instr1 number(10);  
    v_instr2 number(10); 
    
	
begin 
	-- 打开目标文件
	v_out_file := UTL_FILE.FOPEN('D_OUTPUT', p_file_path, 'w', 32767);
	-- 删除历史调用该过程遗留下来的记录
	execute immediate 'truncate table t_table_details';
	-- 查询数据字典`user_tab_cols` 读入 t_table_details
	insert into t_table_details select table_name, column_name, data_type, data_length from user_tab_cols where table_name = upper(p_table_name);
	-- 生成 create head 部分
	select distinct 'create table ' || table_name || '(' ||  CHR(10) || chr(9) into v_file_buf from t_table_details;
	-- 打印 create table T_MAJOR_D312(
	dbms_output.put_line(v_file_buf);
	-- 生成 create 字段部分
	v_cnt := 0;
	for cur_table in (select col_name, col_type, col_size from t_table_details) loop
        if instr(cur_table.col_name, '$') <= 0 then
        	v_cnt := v_cnt + 1;
        	if v_cnt != 1 then
                v_file_buf := v_file_buf || ',' || CHR(10) || chr(9);
            end if;
            
        	if cur_table.col_type = 'DATE' then
        		v_file_buf := v_file_buf || cur_table.col_name || ' ' || cur_table.col_type;
        	else 
        		v_file_buf := v_file_buf || cur_table.col_name || ' ' || cur_table.col_type || '(' || cur_table.col_size || ')';
        	end if;
        end if;
        
    end loop;
	v_file_buf := CHR(10) || v_file_buf || ');' || CHR(10);
	dbms_output.put_line(v_file_buf);
	-- 打印
	-- create table T_MAJOR_D312(
    --    MAJORNO VARCHAR2(32),
    --    MNAME VARCHAR2(32),
    --    LOC VARCHAR2(32),
    --    MDEAN VARCHAR2(32),
    --    SUM_EVALUATION NUMBER(22),
    --    );
    
    
    -- 添加约束
    v_cons_head := 'alter table ' || p_table_name || ' add constraint ';
    select user into v_username from dual;
    for cur_cons in (select ctr.owner as schema_name,
                       ctr.constraint_name,
	               	   ctr.constraint_type,
                       ctr.table_name,
                       col.column_name,
                       ctr.search_condition as constraint,
                       ctr.status
                from sys.dba_constraints ctr
                join sys.dba_cons_columns col
                     on ctr.owner = col.owner
                     and ctr.constraint_name = col.constraint_name
                     and ctr.table_name = col.table_name 
                where col.table_name = upper(p_table_name)
                   and ctr.owner = v_username
                   and column_name != 'LABEL'
                order by ctr.owner, ctr.table_name, ctr.constraint_name)
    loop
    	-- 判断是哪一种约束类型
    	-- ALTER TABLE T_STUD_D312 ADD CONSTRAINT SEX_CK CHECK (sex in('男', '女', '其它')) ENABLE NOVALIDATE"
    	if cur_cons.constraint_type = 'C' then
    		v_cons := v_cons_head || cur_cons.constraint_name || ' check (' || cur_cons.constraint || ');';
    	-- ALTER TABLE T_STUD_D312 ADD SNO_PK PRIMARY KEY (SNO)
    	elsif cur_cons.constraint_type = 'P' then
    		v_cons := v_cons_head || cur_cons.constraint_name || ' primary key (' || cur_cons.column_name || ');';
    	-- -- ALTER TABLE T_STUD_D312 ADD XX_UK UNIQUE (SNO)
    	elsif cur_cons.constraint_type = 'U' then
    		v_cons := v_cons_head || cur_cons.constraint_name ||'unique(' || cur_cons.column_name || ');';
    	--  ALTER TABLE T_STUD_D312 ADD CONSTRAINT MAJORNO_FK FOREIGN KEY (MAJORNO) REFERENCES T_MAJOR_D312 (MAJORNO) ENABLE NOVALIDATE
    	elsif cur_cons.constraint_type = 'R' then
    		select t2.table_name, a2.column_name 
    		into v_rtable_name, v_rcol 
    		from 
    			user_constraints t1, 
    			user_constraints t2, 
    			user_cons_columns a1, 
    			user_cons_columns a2 
    		where 
    			t1.constraint_name = cur_cons.constraint_name
    			and t1.owner = upper(v_username) 
    			and t1.table_name = UPPER(p_table_name) 
    			and t1.r_constraint_name = t2.constraint_name 
    			and t1.constraint_name = a1.constraint_name 
    			and t1.r_constraint_name = a2.constraint_name;
                
    		v_cons := v_cons_head || cur_cons.constraint_name ||' foreign key (' || cur_cons.column_name || ') references ' || v_rtable_name || '(' || v_rcol || ');';
    	
        /*
    	elsif cur_cons.constraint_type = 'V' then
    		select * into v_cons from dual where 1=2;
    	elsif cur_cons.constraint_type = 'O' then
    		select * into v_cons from dual where 1=2;
    	else 
    		select * into v_cons from dual where 1=2;
    	*/
    	end if;
    	dbms_output.put_line(v_cons);
    	v_file_buf := v_file_buf || v_cons || CHR(10);
    	-- 激活约束
		-- ALTER TABLE T_STUD_D312 ENABLE CONSTRAINT SEX_CK
		if cur_cons.status = 'ENABLED' then
			v_cons_state := 'enable';
		else
			v_cons_state := 'disable';
		end if;
		v_set_cons_state := 'alter table ' || p_table_name || ' ' || v_cons_state || ' constraint ' ||  cur_cons.constraint_name || ';';
		v_file_buf := v_file_buf || v_set_cons_state || CHR(10);
    end loop;
    
    
    -- 默认值
	-- ALTER TABLE T_STUD_D312 MODIFY (SUM_EVALUATION DEFAULT 100)
	v_default_head := 'alter table ' || p_table_name || ' modify (';
    for cur_val in (
        select column_name, data_default, data_type from dba_tab_columns 
        	where table_name = upper(p_table_name) 
        		and owner=v_username)
	loop
		if cur_val.data_default is not null then
			v_default := v_default_head || cur_val.column_name || ' default ' || cur_val.data_default || ');';
			dbms_output.put_line(v_default);
			v_file_buf := v_file_buf || v_default || CHR(10);
		end if;
	end loop;
	
	
	-- insert 语句
    for cur_field_name in (select cname, coltype from col where tname = upper(p_table_name) order by colno) 
    loop
    	if v_fields is null then  
	    	-- MAJORNO
            v_fields := cur_field_name.cname;
        else  
	        -- ||','||MNAME
            v_fields := v_fields || '||''' || ',' || '''||' || cur_field_name.cname;
        end if;  
    end loop;  
    dbms_output.put_line(v_fields);  
    -- 打印
    -- MAJORNO||','||MNAME||','||LOC||','||MDEAN||','||SUM_EVALUATION
    
    v_sql := 'select '||''''||'insert into '||p_table_name||' values(''||' || v_fields || '||'')'' from ' || p_table_name;
    dbms_output.put_line(v_sql);
    -- 打印
    -- select 'insert into t_major_D312 values('||MAJORNO||','||MNAME||','||LOC||','||MDEAN||','||SUM_EVALUATION||')' from t_major_D312
    -- 执行上面这句话会打印
    -- insert into t_major_D312 values(00,计科,主校区,王斌,1000)
	-- insert into t_major_D312 values(08,大数据,主校区,廖胜辉,954)
    -- insert into t_major_D312 values(16,物联网,新校区,彭军,1000)
	-- insert into t_major_D312 values(24,信安,新校区,黄家玮,1000)
	
	
    -- insert 语句生成
    open cur_sql for v_sql;
    loop
    	fetch cur_sql into v_row;
    	exit when cur_sql%notfound;
    	-- v_row 即上面那四个insert
		v_instr1 := instr(v_row,'(');  
		v_instr2 := instr(v_row,')');  
		-- insert into t_major_D312 values(
        v_ldata := substr(v_row,1,v_instr1);
        -- 00,计科,主校区,王斌,1000
        v_rdata := substr(v_row,v_instr1 + 1, v_instr2-v_instr1 - 1);  
		dbms_output.put_line(v_ldata);
		dbms_output.put_line(v_rdata);
    	execute immediate 'truncate table t_fields';
    	-- split bt sep=',' 得到各字段信息
    	insert into t_fields select regexp_substr(v_rdata, '[^,]+', 1, level) from dual  
    						connect by regexp_substr(v_rdata,'[^,]+', 1, level) is not null;
    	
    	v_cnt := 0;
    	for cur_field in (select field from t_fields)
    	loop
    		if v_cnt = 0 then
    			v_ldata := v_ldata || fix_field(p_table_name, cur_field.field, v_cnt+1);
    		else 
	    		v_ldata := v_ldata || ',' || fix_field(p_table_name, cur_field.field, v_cnt+1);
	    	end if;
    		v_cnt := v_cnt + 1;
    	end loop;
    	-- v_ldata存储完整 insert 语句
    	v_ldata := v_ldata || ');';
    	v_file_buf := v_file_buf || v_ldata || CHR(10);
    end loop;
    close cur_sql;
    
    

    dbms_output.put_line(v_file_buf);
    UTL_FILE.PUT_LINE(v_out_file, v_file_buf);
	UTL_FILE.FCLOSE(v_out_file);
end;
/
show error;
exec p_exp_manual_D312('t_stud_D312'); 
```

```plsql
create or replace function fix_field(p_table_name varchar2, p_col_name varchar2, p_colno number) return varchar2  
as  
v_value varchar2(4096);  
v_col_type varchar2(99);  
begin  
	dbms_output.put_line('in function...');
    select coltype into v_col_type from col where tname = upper(p_table_name) and colno = p_colno; 
    dbms_output.put_line(v_col_type);
    dbms_output.put_line('before format:' || v_value);
    if v_col_type = 'DATE' then
        v_value:= '''' || to_char(to_date(p_col_name),'dd-Month-yy') || '''';
    elsif v_col_type = 'VARCHAR' or v_col_type = 'VARCHAR2' then  
        v_value := '''' || p_col_name|| '''';  
    else  
    	v_value := p_col_name;  
    end if; 
    dbms_output.put_line('after format:' || v_value);
    dbms_output.put_line('out funtion...');
    return v_value;    
end;
/
```

最终导出文档内容如下

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111232202764.png" alt="image-20211123220249512" style="zoom:67%;" />

尝试导入，可以看出，整个过程是成功的

```plsql
start E:\App\Lemonade\oradata\backuptest\test.txt;
```

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111232130107.png" alt="image-20211123213013033" style="zoom:67%;" />

## 四、心得体会

本次实现主要围绕 profile 的相关内容，备份以及逻辑导出的实现。

前两块内容属于比较基础，考察熟练度以及理解

所以重点在最后一个**逻辑导出实现**上，新的体会如下

1. 一开始比较盲目，于是我尝试直接看 Oracle 原生 `exp` 导出的结果是什么样的；但其中遇到了乱码等问题，所以尝试通过日志文件取解决
2. 关于生成 `create`  过程，如果直接读取 `user_tab_cols`，会把一些隐藏列也考虑进去。所以需要实现利用 `if` 滤除这些隐藏列信息
3. 过程中涉及大量数据字典，有些数据字典会在编译过程中提示报错不存在，查询后得知需要额外授权 `select on`，如下

```plsql
sqlplus SYSTEM/sys as sysdba;
grant select on sys.dba_cons_columns to C##U_LZC_D312;
grant select on sys.dba_constraints to C##U_LZC_D312;
grant select on dba_tab_columns to C##U_LZC_D312;
```

3. 关于 `select into`一次性赋值多个的错误

   `select col1 into v1, col2 into v2`  的写法是错误的，应写为 `select col1, col2 into v1, v2`

4. 关于生成 `insert` 语句过程的一些小 Tips

   由于采用动态 SQL ，我们会得到 `insert into t_major_D312 values(24,信安,新校区,黄家玮,1000)` 类似的语句，但是我们需要对每个字段调用`fix_field`函数进行单独处理，所以问题在于如何得到个字段，例如`24`, `信安`, `新校区` 等等。

   若采用循环以及`substr`  的方法显然过于冗余，在这里我们采用下面语句配合正则表达式，达到如同一般编程语言中`split`函数的效果

   ```plsql
   insert into t_fields 
   	select regexp_substr(v_rdata, '[^,]+', 1, level) from dual 
   	connect by regexp_substr(v_rdata,'[^,]+',1,level) is not null;
   ```

总的来说这一次综合实验把之前所学的各种基本操作内容重新巩固了一遍，尤其是有关数据字典内容部分，是一次收获很大的实验经历。

## 五、源码

```plsql
---- 创建 PROFILE 文件 ----
sqlplus SYSTEM/sys
grant create profile to C##U_LZC_D312;
conn C##U_LZC_D312/sys;
drop profile C##pTester;
create profile C##pTester
	LIMIT FAILED_LOGIN_ATTEMPTS 3
	CONNECT_TIME 60
	PASSWORD_LOCK_TIME 30;
	
---- 使用 PROFILE ----
-- 激活资源限制
sqlplus SYSTEM/sys
alter system set resource_limit=true;

conn C##U_LZC_D312/sys;
drop user C##Tester;
create user C##Tester identified by Tester123
	default tablespace tabspace_D312
	quota 50M on tabspace_D312
	profile C##pTester;

---- 将角色 RESOURCE 指派给用户 Tester ----
grant resource to C##Tester;
-- grant connect, resource, dba to C##Tester;


---- 导入表 ----
exp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\major.dmp tables=(t_major_D312)

conn C##Tester/Tester123;
drop table t_major_D312;

imp C##Tester/Tester123 file=E:\App\Lemonade\oradata\backuptest\major.dmp tables=(t_major_D312)

col majorno format a8;
col mname format a8;
col loc format a8;
col mdean format a8;
col majorno format a8;
col SUM_EVALUATION for 9999

select * from t_major_D312;


---- 实现逻辑导出 ----
-- 1. 借鉴 Oracle
exp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\t_stud.dmp tables=(t_stud2_info_D312)
imp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\major.dmp show=y log=abcd_log.log full=y

-- 2. 预处理
create or replace  directory D_OUTPUT  as 'E:/App/Lemonade/oradata/backuptest/' ;
grant read, write on directory D_OUTPUT  to C##U_LZC_D312;

conn C##U_LZC_D312/sys;

drop t_table_details;
create table t_table_details(
    table_name varchar(256),
    col_name varchar(256),
    col_type varchar(32),
    col_size number
);

drop table t_fields;
create table t_fields(
	field varchar2(256)
);

-- 3. fix_field 函数实现
create or replace function fix_field(p_table_name varchar2, p_col_name varchar2, p_colno number) return varchar2  
as  
v_value varchar2(4096);  
v_col_type varchar2(99);  
begin  
	dbms_output.put_line('in function...');
    select coltype into v_col_type from col where tname = upper(p_table_name) and colno = p_colno; 
    dbms_output.put_line(v_col_type);
    dbms_output.put_line('before format:' || v_value);
    if v_col_type = 'DATE' then
        v_value:= '''' || to_char(to_date(p_col_name),'dd-Month-yy') || '''';
    elsif v_col_type = 'VARCHAR' or v_col_type = 'VARCHAR2' then  
        v_value := '''' || p_col_name|| '''';  
    else  
    	v_value := p_col_name;  
    end if; 
    dbms_output.put_line('after format:' || v_value);
    dbms_output.put_line('out funtion...');
    return v_value;    
end;
/

-- 4. 逻辑导出过程实现
set serveroutpu on;
set linesize 500;
create or replace procedure p_exp_manual_D312 (p_table_name in varchar2, p_file_path in varchar2 default 'test.txt') 
as
	-- 目标文件
	v_out_file UTL_FILE.FILE_TYPE;
	-- 要写入到目标文件的字符串
	v_file_buf varchar2(32767);
    -- 记录用户名
    v_username varchar2(32);
    
    
    -- 约束内容
    v_cons_head varchar2(256);
    v_cons varchar2(256);
    v_cons_state varchar2(32);
    v_set_cons_state varchar2(256);
    -- 被引用为外键的列
    v_rcol varchar2(256);
    -- 被引用外键的表
    v_rtable_name varchar2(256);
    
    -- 存储默认值
    v_default_head varchar2(256);
    v_default varchar2(256);
    
    
    -- insert 内容
    -- MAJORNO||','||MNAME||','||LOC||','||MDEAN||','||SUM_EVALUATION
	v_fields varchar2(4096); 
	-- select 'insert into t_major_D312 values(' || 上面的fields || ')' from t_major_D312
	v_sql varchar2(4096);  
	 
	type curType is ref cursor;  
	cur_sql curType;
	-- 执行 v_sql 后的每一行，比如 insert into t_major_D312 values(00,计科,主校区,王斌,1000)
	v_row varchar2(4096); 
	-- v_row中'('之前的部分
	v_ldata varchar2(32765);
    -- v_row中'()'之间的部分
    v_rdata varchar2(32765);  
    -- 第几列
    v_cnt number(10);  
    -- 记录左右括号的位置
    v_instr1 number(10);  
    v_instr2 number(10); 
    
	
begin 
	-- 打开目标文件
	v_out_file := UTL_FILE.FOPEN('D_OUTPUT', p_file_path, 'w', 32767);
	-- 删除历史调用该过程遗留下来的记录
	execute immediate 'truncate table t_table_details';
	-- 查询数据字典`user_tab_cols` 读入 t_table_details
	insert into t_table_details select table_name, column_name, data_type, data_length from user_tab_cols where table_name = upper(p_table_name);
	-- 生成 create head部分
	select distinct 'create table ' || table_name || '(' ||  CHR(10) || chr(9) into v_file_buf from t_table_details;
	-- 打印 create table T_MAJOR_D312(
	dbms_output.put_line(v_file_buf);
	-- 生成 create 字段部分
	v_cnt := 0;
	for cur_table in (select col_name, col_type, col_size from t_table_details) loop
        if instr(cur_table.col_name, '$') <= 0 then
        	v_cnt := v_cnt + 1;
        	if v_cnt != 1 then
                v_file_buf := v_file_buf || ',' || CHR(10) || chr(9);
            end if;
            
        	if cur_table.col_type = 'DATE' then
        		v_file_buf := v_file_buf || cur_table.col_name || ' ' || cur_table.col_type;
        	else 
        		v_file_buf := v_file_buf || cur_table.col_name || ' ' || cur_table.col_type || '(' || cur_table.col_size || ')';
        	end if;
        end if;
        
    end loop;
	v_file_buf := CHR(10) || v_file_buf || ');' || CHR(10);
	dbms_output.put_line(v_file_buf);
	-- 打印
	-- create table T_MAJOR_D312(
    --    MAJORNO VARCHAR2(32),
    --    MNAME VARCHAR2(32),
    --    LOC VARCHAR2(32),
    --    MDEAN VARCHAR2(32),
    --    SUM_EVALUATION NUMBER(22),
    --    );
    
    
    -- 添加约束
    v_cons_head := 'alter table ' || p_table_name || ' add constraint ';
    select user into v_username from dual;
    for cur_cons in (select ctr.owner as schema_name,
                       ctr.constraint_name,
	               	   ctr.constraint_type,
                       ctr.table_name,
                       col.column_name,
                       ctr.search_condition as constraint,
                       ctr.status
                from sys.dba_constraints ctr
                join sys.dba_cons_columns col
                     on ctr.owner = col.owner
                     and ctr.constraint_name = col.constraint_name
                     and ctr.table_name = col.table_name 
                where col.table_name = upper(p_table_name)
                   and ctr.owner = v_username
                   and column_name != 'LABEL'
                order by ctr.owner, ctr.table_name, ctr.constraint_name)
    loop
    	-- 判断是哪一种约束类型
    	-- ALTER TABLE T_STUD_D312 ADD CONSTRAINT SEX_CK CHECK (sex in('男', '女', '其它')) ENABLE NOVALIDATE"
    	if cur_cons.constraint_type = 'C' then
    		v_cons := v_cons_head || cur_cons.constraint_name || ' check (' || cur_cons.constraint || ');';
    	-- ALTER TABLE T_STUD_D312 ADD SNO_PK PRIMARY KEY (SNO)
    	elsif cur_cons.constraint_type = 'P' then
    		v_cons := v_cons_head || cur_cons.constraint_name || ' primary key (' || cur_cons.column_name || ');';
    	-- -- ALTER TABLE T_STUD_D312 ADD XX_UK UNIQUE (SNO)
    	elsif cur_cons.constraint_type = 'U' then
    		v_cons := v_cons_head || cur_cons.constraint_name ||'unique(' || cur_cons.column_name || ');';
    	--  ALTER TABLE T_STUD_D312 ADD CONSTRAINT MAJORNO_FK FOREIGN KEY (MAJORNO) REFERENCES T_MAJOR_D312 (MAJORNO) ENABLE NOVALIDATE
    	elsif cur_cons.constraint_type = 'R' then
    		select t2.table_name, a2.column_name 
    		into v_rtable_name, v_rcol 
    		from 
    			user_constraints t1, 
    			user_constraints t2, 
    			user_cons_columns a1, 
    			user_cons_columns a2 
    		where 
    			t1.constraint_name = cur_cons.constraint_name
    			and t1.owner = upper(v_username) 
    			and t1.table_name = UPPER(p_table_name) 
    			and t1.r_constraint_name = t2.constraint_name 
    			and t1.constraint_name = a1.constraint_name 
    			and t1.r_constraint_name = a2.constraint_name;
                
    		v_cons := v_cons_head || cur_cons.constraint_name ||' foreign key (' || cur_cons.column_name || ') references ' || v_rtable_name || '(' || v_rcol || ');';
    	
        /*
    	elsif cur_cons.constraint_type = 'V' then
    		select * into v_cons from dual where 1=2;
    	elsif cur_cons.constraint_type = 'O' then
    		select * into v_cons from dual where 1=2;
    	else 
    		select * into v_cons from dual where 1=2;
    	*/
    	end if;
    	dbms_output.put_line(v_cons);
    	v_file_buf := v_file_buf || v_cons || CHR(10);
    	-- 激活约束
		-- ALTER TABLE T_STUD_D312 ENABLE CONSTRAINT SEX_CK
		if cur_cons.status = 'ENABLED' then
			v_cons_state := 'enable';
		else
			v_cons_state := 'disable';
		end if;
		v_set_cons_state := 'alter table ' || p_table_name || ' ' || v_cons_state || ' constraint ' ||  cur_cons.constraint_name || ';';
		v_file_buf := v_file_buf || v_set_cons_state || CHR(10);
    end loop;
    
    
    -- 默认值
	-- ALTER TABLE T_STUD_D312 MODIFY (SUM_EVALUATION DEFAULT 100)
	v_default_head := 'alter table ' || p_table_name || ' modify (';
    for cur_val in (
        select column_name, data_default, data_type from dba_tab_columns 
        	where table_name = upper(p_table_name) 
        		and owner=v_username)
	loop
		if cur_val.data_default is not null then
			v_default := v_default_head || cur_val.column_name || ' default ' || cur_val.data_default || ');';
			dbms_output.put_line(v_default);
			v_file_buf := v_file_buf || v_default || CHR(10);
		end if;
	end loop;
	
	
	-- insert 语句
    for cur_field_name in (select cname, coltype from col where tname = upper(p_table_name) order by colno) 
    loop
    	if v_fields is null then  
	    	-- MAJORNO
            v_fields := cur_field_name.cname;   
        else  
	        -- ||','||MNAME||
            v_fields := v_fields || '||''' || ',' || '''||' || cur_field_name.cname;
        end if;  
    end loop;  
    dbms_output.put_line(v_fields);  
    -- 打印
    -- MAJORNO||','||MNAME||','||LOC||','||MDEAN||','||SUM_EVALUATION
    
    v_sql := 'select '||''''||'insert into '||p_table_name||' values(''||' || v_fields || '||'')'' from ' || p_table_name;
    dbms_output.put_line(v_sql);
    -- 打印
    -- select 'insert into t_major_D312 values('||MAJORNO||','||MNAME||','||LOC||','||MDEAN||','||SUM_EVALUATION||')' from t_major_D312
    -- 执行上面这句话会打印
    -- insert into t_major_D312 values(00,计科,主校区,王斌,1000)
	-- insert into t_major_D312 values(08,大数据,主校区,廖胜辉,954)
    -- insert into t_major_D312 values(16,物联网,新校区,彭军,1000)
	-- insert into t_major_D312 values(24,信安,新校区,黄家玮,1000)
	
	
    -- insert 语句生成
    open cur_sql for v_sql;
    loop
    	fetch cur_sql into v_row;
    	exit when cur_sql%notfound;
    	-- v_row 即上面那四个insert
		v_instr1 := instr(v_row,'(');  
		v_instr2 := instr(v_row,')');  
		-- insert into t_major_D312 values(
         v_ldata := substr(v_row,1,v_instr1);
         -- 00,计科,主校区,王斌,1000
         v_rdata := substr(v_row,v_instr1 + 1, v_instr2-v_instr1 - 1);  
		dbms_output.put_line(v_ldata);
		dbms_output.put_line(v_rdata);
    	execute immediate 'truncate table t_fields';
    	-- split bt sep=',' 得到各字段信息
    	insert into t_fields select regexp_substr(v_rdata, '[^,]+', 1, level) from dual  
    						connect by regexp_substr(v_rdata,'[^,]+', 1, level) is not null;
    	
    	v_cnt := 0;
    	for cur_field in (select field from t_fields)
    	loop
    		if v_cnt = 0 then
    			v_ldata := v_ldata || fix_field(p_table_name, cur_field.field, v_cnt+1);
    		else 
	    		v_ldata := v_ldata || ',' || fix_field(p_table_name, cur_field.field, v_cnt+1);
	    	end if;
    		v_cnt := v_cnt + 1;
    	end loop;
    	-- v_ldata存储完整 insert 语句
    	v_ldata := v_ldata || ');';
    	v_file_buf := v_file_buf || v_ldata || CHR(10);
    end loop;
    close cur_sql;
    
    

    dbms_output.put_line(v_file_buf);
    UTL_FILE.PUT_LINE(v_out_file, v_file_buf);
	UTL_FILE.FCLOSE(v_out_file);
end;
/
show error;
exec p_exp_manual_D312('t_stud_D312'); 

start E:\App\Lemonade\oradata\backuptest\test.txt;
```

一些脚本，用于熟悉数据字典的内容即相关操作的效果

```plsql
select ctr.owner as schema_name,
       ctr.constraint_name,
       ctr.constraint_type,
       ctr.table_name,
       col.column_name,
       ctr.search_condition as constraint,
       ctr.status
from sys.dba_constraints ctr
join sys.dba_cons_columns col
     on ctr.owner = col.owner
     and ctr.constraint_name = col.constraint_name
     and ctr.table_name = col.table_name 
where col.table_name = upper('t_stud_D312')
   and column_name != 'LABEL'
order by ctr.owner, ctr.table_name, ctr.constraint_name;


-- SELECT constraint_name, table_name, r_constraint_name FROM all_constraints WHERE table_name = UPPER('t_stud_D312') and owner = 'C##U_LZC_D312';


SELECT a.table_name, a.column_name, a.constraint_name, c.owner, 
       -- referenced pk
       c.r_owner, c_pk.table_name r_table_name, c_pk.constraint_name r_pk
  FROM all_cons_columns a
  JOIN all_constraints c ON a.owner = c.owner
                        AND a.constraint_name = c.constraint_name
  JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                           AND c.r_constraint_name = c_pk.constraint_name
 WHERE c.constraint_type = 'R'
   AND a.table_name = UPPER('t_stud_D312');



select t1.table_name,
       t2.table_name as "TABLE_NAME(R)",
       t1.constraint_name,
       t1.r_constraint_name as "CONSTRAINT_NAME(R)",
       a1.column_name,
       a2.column_name as "COLUMN_NAME(R)"
from user_constraints t1, user_constraints t2, user_cons_columns a1, user_cons_columns a2
where t1.owner = upper('C##U_LZC_D312') and
      t1.table_name = UPPER('t_stud_D312') and
      t1.r_constraint_name = t2.constraint_name and
      t1.constraint_name = a1.constraint_name and
      t1.r_constraint_name = a2.constraint_name;
      
      
      
      
Select TABLE_NAME, COLUMN_NAME, DATA_DEFAULT, data_type
from DBA_TAB_COLUMNS
where TABLE_NAME = UPPER('t_major_D312') and owner = 'C##U_LZC_D312';
```

## References

[TRUNCATE TABLE vs. DELETE vs. DROP TABLE: Removing Tables and Data in SQL](https://learnsql.com/blog/difference-between-truncate-delete-and-drop-table-in-sql/)

```plsql
set serveroutpu on;
declare 
	str varchar2(32);
	ans varchar2(32);
begin
	str := 'A,B,C,D';
	select regexp_substr(str , '[^,]+', 1, 1) into ans from dual;
	dbms_output.put_line(ans);
end;
/
-- 打印 A

set serveroutpu on;
declare 
	str varchar2(32);
	ans varchar2(32);
begin
	str := 'A,B,C,D';
	select regexp_substr(str , '[^,]+', 1, 2) into ans from dual;
	dbms_output.put_line(ans);
end;
/
-- 打印 B

set serveroutpu on;
declare 
	str varchar2(32);
	ans varchar2(32);
begin
	str := 'A,B,C,D';
	select regexp_substr(str , '[^,]+', 1, level) into ans from dual;
	dbms_output.put_line(ans);
end;
/
-- 报错 ORA-01788: 此查询块中要求 CONNECT BY 子句

set serveroutpu on;
declare 
	str varchar2(32);
	ans varchar2(32);
begin
	str := 'A,B,C,D';
	select regexp_substr(str , '[^,]+', 1, level) into ans from dual
		connect by regexp_substr(str,'[^,]+', 1, level) is not null;
	dbms_output.put_line(ans);
end;
/
-- 报错 ORA-01422: 实际返回的行数超出请求的行数

select level from dual connect by regexp_substr('A, B, C, D','[^,]+', 1, level);
-- 报错


select regexp_substr('A, B, C, D' , '[^,]+', 1, level) from dual
		connect by regexp_substr('A, B, C, D','[^,]+', 1, level) is not null;
		
		
每次 connect by 子句为真，则 level ++，直至为假

select level from dual connect by rownum <= 5;
```

https://blog.csdn.net/zwjzqqb/article/details/79066224

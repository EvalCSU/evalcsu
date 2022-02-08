# 实验四、数据备份恢复与基于数据字典的数据库操作

## 一、目的与要求

本实验主要是熟悉 ORACLE 的备份与恢复技术。针对 ORACLE 表空间进行相关操作。

## 二、操作环境

- 硬件：主频2GHz以上服务器（内存2GB以上、硬件空闲2.2GB以上），主频1GHz以上微机，内存1GB以上。
- 软件：WINDOWS XP/2000/2003/或Win7/Win8/Win10等。如操作系统是 SERVER版， 可安装ORACLE/9i/10g/11g/12C FOR NT/WINDOWS(注意有32位与64位的区别，可选企业版)； 如果Windows非server如XP/win7等，安装时请选择个人版(PERSONAL)，注意安装时要有兼容性设置与用管理员运行。安装过程中需要关注系统预定义的账号SYS与SYSTEM的密码设置。

## 三、实验内容

### 1. 建立对应 3GB 大小的外部文件

```plsql
drop tablespace tabspace_D312;
create tablespace tabspace_D312 
datafile 'E:\App\Lemonade\oradata\TABLESPACE_D312\data01.dbf' size 3G 
extent management local autoallocate
online;
```

运行后可以看见在指定目录下生成了约 3G 大小的文件

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111210901985.png)

### 2. 重建 major 表与 stud 表于该表空间

```plsql
DROP TABLE t_stud2_D312;
DROP TABLE t_major2_D312;
CREATE TABLE t_major2_D312(
    majorno VARCHAR2(32) PRIMARY KEY,
    mname VARCHAR2(32),
    loc VARCHAR2(32),
    mdean VARCHAR2(32),
    CONSTRAINT loc_ck2 check(loc in('主校区','南校区','新校区','铁道校区','湘雅校区'))
)tablespace tabspace_D312;

DROP TABLE t_stud2_D312;
CREATE TABLE t_stud2_D312(
    sno VARCHAR2(20) PRIMARY KEY,
    sname VARCHAR2(32),
    sex VARCHAR2(32),
    tel VARCHAR2(32),
    email VARCHAR2(32),
    birthday DATE,
    mno VARCHAR2(20),
    majorno VARCHAR2(32),
    CONSTRAINT sex_ck2 check(sex in('男', '女', '其它')),
    CONSTRAINT email_ck2 check(email like '%@%.%'),
    CONSTRAINT birthday_ck2 check(birthday > TO_DATE('19990731', 'YYYYMMDD')),
    CONSTRAINT majorno_ck2 check(majorno in substr(sno, 3, 2)),
    CONSTRAINT mno_fk2 FOREIGN KEY(mno) REFERENCES t_stud2_D312(sno),
    CONSTRAINT majorno_fk2 FOREIGN KEY(majorno) REFERENCES t_major2_D312(majorno)
) tablespace tabspace_D312;
```

### 3. 重新产生样本值

重新产生样本值，包括千万级数据的stud表，对比实验三中产生样本值的时间

```plsql
insert into t_major2_D312(majorno, mname, loc, mdean) select majorno, mname, loc, mdean from t_major_D312;

insert into t_stud2_D312(sno, sname, sex, tel, email, birthday, mno, majorno) select sno, sname, sex, tel, email, birthday, mno, majorno from t_stud_D312;


/*
insert into t_major2_D312 values('00','计科','主校区','王斌');
insert into t_major2_D312 values('08','大数据','主校区','廖胜辉');
insert into t_major2_D312 values('16','物联网','新校区','彭军');
insert into t_major2_D312 values('24','信安','新校区','黄家玮');

set serveroutpu on;
declare
	type snoArray     is varray(40) of t_stud2_D312.sno%TYPE;
	type snameArray   is varray(40) of t_stud2_D312.sname%TYPE;
	type sexArray     is varray(40) of t_stud2_D312.sex%TYPE;
	type telArray     is varray(40) of t_stud2_D312.tel%TYPE;
	type emailArray   is varray(40) of t_stud2_D312.email%TYPE;
	type birthArray   is varray(40) of t_stud2_D312.birthday%TYPE;
	type mnoArray     is varray(40) of t_stud2_D312.mno%TYPE;
	type majornoArray is varray(40) of t_stud2_D312.majorno%TYPE;
	type majorArray   is varray(4) of varchar2(32);
	
	i        NUMBER;
	snos     snoArray     := snoArray();
	snames   snameArray   := snameArray();
	sexes    sexArray     := sexArray();
	tels     telArray     := telArray();
	emails   emailArray   := emailArray();
	births   birthArray   := birthArray();
	mnos     mnoArray     := mnoArray();
	majornos majornoArray := majornoArray();
	majors   majorArray  := majorArray('J', 'D', 'W', 'X');
begin
	for k in 1..4 loop
        for j in 1..10 loop
        	i := (k - 1) * 10 + j;
            snos.extend;
            snames.extend;
            sexes.extend;
            tels.extend;
            emails.extend;
            births.extend;
            mnos.extend;
            majornos.extend;
            
            majornos(i) := TO_CHAR((k-1) * 8, 'FM00');
            -- 不知道为什么不用REPLACE时 常量||变量 会添加一个空格 
            -- snos(i) := REPLACE('82' || majornos(i) || '191' || TO_CHAR(i, 'FM00'),' ', '');
            snos(i) := '82' || majornos(i) || '1903' || TO_CHAR(i, 'FM00');
            snames(i) := majors(k) || TO_CHAR(i, 'FM00');
            sexes(i) := (case when mod(i, 2) = 0 then '男' else '女' end);
			tels(i) := TO_CHAR(12345678901 + k * 10 + i);
			emails(i) := snos(i) || '@csu.edu.cn';
			births(i) := TO_DATE('20010101', 'YYYYMMDD')+ k*10 + i;
			mnos(i) := snos((k-1)*10+1);
			dbms_output.put_line(snos(i) || ' ' || snames(i) || ' ' || sexes(i) || ' ' || tels(i) || ' ' || emails(i) || ' ' || TO_CHAR(births(i), 'YY-MM-DD') || ' ' || mnos(i) || ' ' || majornos(i));
		end loop;
	end loop;
	
	DELETE FROM t_stud2_D312;
	for i in 1..40 loop
		INSERT INTO t_stud2_D312 VALUES(snos(i), snames(i), sexes(i), tels(i), emails(i), births(i), mnos(i), majornos(i));
    end loop;
    -- 插入自身数据
    INSERT INTO t_stud2_D312 VALUES('8208191312', '李智聪', '男', '17759573563', '1319871052@qq.com', TO_DATE('20010125', 'YYYYMMDD'), '8208190311', '08');
end;
/
*/
```

生成 stud_info 表

```plsql
set timing on;
delete from t_time where event='生成随机字段(指定表空间)';
exec p_record_time_D312 ('生成随机字段(指定表空间)','start');
drop table t_random22;
create table t_random22(
	sex varchar2(32),
    tel varchar2(32),
    email varchar2(32),
    birthday date
) tablespace tabspace_D312;

insert /*+ append */ into t_random22 select f_get_sex(), f_get_tel(), f_get_email(), f_get_birth() from xmltable('1 to 11520000');
commit;

exec p_record_time_D312 ('生成随机字段(指定表空间)','end');

drop table t_stud2_info_D312;
create table t_stud2_info_D312(
	sno varchar2(32),
    sname varchar2(32),
    sex varchar2(32),
    tel varchar2(32),
    email varchar2(32),
    birthday date
) tablespace tabspace_D312;

drop synonym t_stud2;
create synonym t_stud2 for t_stud2_info_D312;

exec p_record_time_D312 ('生成最终数据集(表空间)','start');
insert into t_stud2 
	select 
		A.sno, B.name, C.sex, C.tel, C.email, C.birthday 
	from 
	(select t_sno_ab.*, rownum rn1 from t_sno_ab)  A,
    (select t_name.*, rownum rn2 from t_name)      B,
    (select t_random22.*, rownum rn3 from t_random22)  C
	where rn1 = rn2 and rn2 = rn3;
	
exec p_record_time_D312 ('生成最终数据集(指定表空间)','end');

set linesize 500;
col event format a30;
col start_time format a33;
col end_time format a33;
col time_consume format a20;
select * from t_time order by start_time;
```

![image-20211121232808213](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111212328295.png)

可以看到由于事先指定了表空间，所以生成数据集速度明显快了许多。

### 4. 导入导出数据

用 EXP 导出数据与 IMP 导入数据

```plsql
-- 在命令行中执行
exp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\t_stud2_info.dmp tables=(t_stud2_info_D312)

drop table t_stud2_info_D312;

imp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\t_stud2_info.dmp tables=(t_stud2_info_D312)

select count(*) from t_stud2_info_D312;
```

交互式方式导出导入

```plsql
exp
...

imp
...
```

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111261421179.png" alt="image-20211126142116984" style="zoom:67%;" />



<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111261422853.png" alt="image-20211126142220706" style="zoom:67%;" />

导出导入总用时不到一分钟

这里通过事先删除该表再进行导入验证是否成功导入。

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111261423061.png" alt="image-20211126142309941" style="zoom:67%;" />

### 5. 对表空间进行备份与恢复

尝试对系统表空间 `user` 及自定义表空间 `tabspace_????` 进行备份与恢复

```plsql
-- 查看数据库的归档模式
SELECT dbid, name, log_mode FROM v$database;
```

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211011316.png" alt="image-20211121101113133" style="zoom:67%;" />

由于数据库默认是`noarchivelog`状态，故需要重启数据库修改为`archivelog`状态

```plsql
conn SYSTEM/sys as sysdba;
-- 关闭数据库
shutdown
-- 重启实例
startup mount;
-- 设置归档模式
alter database archivelog;
-- open 数据库
alter database open;

-- 查看数据库的归档模式
SELECT dbid, name, log_mode FROM v$database;
```

再次查询，发现已变为归档模式

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211456169.png" alt="image-20211121145608117" style="zoom:67%;" />

在命令行执行以下命令

```bash
# 连接到 RMAN
rman target SYSTEM/sys nocatalog;

# 备份
backup tablespace users, tabspace_D312 format 'E:\App\Lemonade\oradata\backuptest\%d_%p_%t_%c.dbf';

# %d 数据库名称 
# %p 该备份集中的备份片号，从1开始到创建的文件数 
# %t 备份集时间戳 
# %c 备份片的拷贝数

# 查看表空间备份信息
list backup of tablespace users, tabspace_D312;

# 恢复
startup mount;
run{
	allocate channel ch_1 type disk;
	sql 'alter tablespace users offline';
	sql 'alter tablespace tabspace_D312 offline';
	restore tablespace users, tabspace_D312;
	recover tablespace users, tabspace_D312;
	sql 'alter tablespace users online';
	sql 'alter tablespace tabspace_D312 online';
}
```

备份：

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211534658.png" alt="image-20211121153436538" style="zoom:67%;" />

查看备份结果：

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211535919.png" alt="image-20211121153521814" style="zoom:67%;" />

恢复：

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211552749.png" alt="image-20211121155258620" style="zoom:67%;" />

### 6.  SQL 生成 SQL 1

登录 DBA 用户 system ，通过 cat 字典入口，找到以 DBA_ 开头的相关数据字典，并且每个对象显示 5 条记录（ SQL 生成 SQL ）

```plsql
set heading off;  -- 不显示表的列名
set feedback off; -- 不显示"已选择xx行"
set echo off;
set termout off; -- 不在终端打印，直接打印到script
conn SYSTEM/sys as sysdba;
spool D:\Messy\Experiment\大型数据库\OraExp4_D312\cat_output.sql
select 'select * from '||table_name||' where rownum<=5;' from cat where table_name like 'DBA_%';
spool off

-- 执行
start D:\Messy\Experiment\大型数据库\OraExp4_D312\cat_output.sql
```

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211602420.png" alt="image-20211121160223263" style="zoom:67%;" />

### 7.  SQL 生成 SQL 2

通过查找自己用户下的触发器字典，生成代码将所有触发器的状态改为 disable 并执行。再生成代码，将状态为 disable 的触发器的状态改为 enable ，并执行

```plsql
spool D:\Messy\Experiment\大型数据库\OraExp4_D312\tri_output.sql

select 'alter trigger '||trigger_name||' disable;' from user_triggers;
spool off;

start D:\Messy\Experiment\大型数据库\OraExp4_D312\tri_output.sql

select trigger_name, status from user_triggers;

spool D:\Messy\Experiment\大型数据库\OraExp4_D312\tri_output2.sql
select 'alter trigger '||trigger_name||' enable;' from user_triggers;
spool off;

start D:\Messy\Experiment\大型数据库\OraExp4_D312\tri_output2.sql
```

生成使触发器 `disable` 的 SQL 语句

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211605822.png" alt="image-20211121160542733" style="zoom:67%;" />

执行 SQL 语句后查看触发器状态

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211607873.png" alt="image-20211121160745777" style="zoom:67%;" />

生成使触发器 `enable` 的 SQL 语句

![image-20211121160823449](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211608496.png)

执行 SQL 语句后查看触发器状态

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202111211609900.png" alt="image-20211121160920832" style="zoom:67%;" />

## 四、收获

整体来说本次实验偏向基础性操作内容，旨在加深对表空间、备份恢复机制、数据字典的相关操作。主要收获如下

- 学习了有关数据库归档模式/非归档模式的一些基本知识
- 懂得了如何利用 EXP/IMP 以及 RMAN 进行导入导出、备份恢复数据库操作
- 学会利用数据字典进行一些查询操作，利用 spool 技术进行批量 SQL 语句

## 五、源码

```plsql
-------------------- 建立表空间 --------------------
drop tablespace tabspace_D312;
create tablespace tabspace_D312 
datafile 'E:\App\Lemonade\oradata\TABLESPACE_D312\data01.dbf' size 3G 
extent management local autoallocate
online;

----------- 重建 major 表 以及 stud 表 -----------
DROP TABLE t_stud2_D312;
DROP TABLE t_major2_D312;
CREATE TABLE t_major2_D312(
    majorno VARCHAR2(32) PRIMARY KEY,
    mname VARCHAR2(32),
    loc VARCHAR2(32),
    mdean VARCHAR2(32),
    CONSTRAINT loc_ck2 check(loc in('主校区','南校区','新校区','铁道校区','湘雅校区'))
)tablespace tabspace_D312;

DROP TABLE t_stud2_D312;
CREATE TABLE t_stud2_D312(
    sno VARCHAR2(20) PRIMARY KEY,
    sname VARCHAR2(32),
    sex VARCHAR2(32),
    tel VARCHAR2(32),
    email VARCHAR2(32),
    birthday DATE,
    mno VARCHAR2(20),
    majorno VARCHAR2(32),
    CONSTRAINT sex_ck2 check(sex in('男', '女', '其它')),
    CONSTRAINT email_ck2 check(email like '%@%.%'),
    CONSTRAINT birthday_ck2 check(birthday > TO_DATE('19990731', 'YYYYMMDD')),
    CONSTRAINT majorno_ck2 check(majorno in substr(sno, 3, 2)),
    CONSTRAINT mno_fk2 FOREIGN KEY(mno) REFERENCES t_stud2_D312(sno),
    CONSTRAINT majorno_fk2 FOREIGN KEY(majorno) REFERENCES t_major2_D312(majorno)
) tablespace tabspace_D312;

insert into t_major2_D312(majorno, mname, loc, mdean) select majorno, mname, loc, mdean from t_major_D312;

insert into t_stud2_D312(sno, sname, sex, tel, email, birthday, mno, majorno) select sno, sname, sex, tel, email, birthday, mno, majorno from t_stud_D312;

----------------- 重建 stud_info 表 -----------------
set timing on;
delete from t_time where event='生成随机字段(指定表空间)';
exec p_record_time_D312 ('生成随机字段(表空间)','start');
drop table t_random22;
create table t_random22(
	sex varchar2(32),
    tel varchar2(32),
    email varchar2(32),
    birthday date
) tablespace tabspace_D312;

insert /*+ append */ into t_random22 select f_get_sex(), f_get_tel(), f_get_email(), f_get_birth() from xmltable('1 to 11520000');
commit;

exec p_record_time_D312 ('生成随机字段(指定表空间)','end');

drop table t_stud2_info_D312;
create table t_stud2_info_D312(
	sno varchar2(32),
    sname varchar2(32),
    sex varchar2(32),
    tel varchar2(32),
    email varchar2(32),
    birthday date
) tablespace tabspace_D312;

drop synonym t_stud2;
create synonym t_stud2 for t_stud2_info_D312;

exec p_record_time_D312 ('生成最终数据集(指定表空间)','start');
insert into t_stud2 
	select 
		A.sno, B.name, C.sex, C.tel, C.email, C.birthday 
	from 
	(select t_sno_ab.*, rownum rn1 from t_sno_ab)  A,
    (select t_name.*, rownum rn2 from t_name)      B,
    (select t_random22.*, rownum rn3 from t_random22)  C
	where rn1 = rn2 and rn2 = rn3;
	
exec p_record_time_D312 ('生成最终数据集(指定表空间)','end');

set linesize 500;
col event format a30;
col start_time format a33;
col end_time format a33;
col time_consume format a20;
select * from t_time order by start_time;

----------------- 导入导出数据 -----------------
-- 在命令行中执行
exp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\t_stud2_info.dmp tables=(t_stud2_info_D312);

drop table t_stud2_info_D312;

imp C##U_LZC_D312/sys file=E:\App\Lemonade\oradata\backuptest\t_stud2_info.dmp tables=(t_stud2_info_D312);

select count(*) from t_stud2_info_D312;

-- 查看数据库的归档模式
SELECT dbid, name, log_mode FROM v$database;

conn SYSTEM/sys as sysdba;
-- 关闭数据库
shutdown
-- 重启实例
startup mount;
-- 设置归档模式
alter database archivelog;
-- open 数据库
alter database open;

-- 再次查看数据库的归档模式
SELECT dbid, name, log_mode FROM v$database;

-------------------- 备份 --------------------
-- 连接到 RMAN
rman target SYSTEM/sys nocatalog;

backup tablespace users, tabspace_D312 format 'E:\App\Lemonade\oradata\backuptest\%d_%p_%t_%c.dbf';

-- 查看表空间备份信息
list backup of tablespace users, tabspace_D312;

-- 恢复
startup mount;
run{
	allocate channel ch_1 type disk;
	sql 'alter tablespace users offline';
	sql 'alter tablespace tabspace_D312 offline';
	restore tablespace users, tabspace_D312;
	recover tablespace users, tabspace_D312;
	sql 'alter tablespace users online';
	sql 'alter tablespace tabspace_D312 online';
}

-------------------- 生成 SQL 1 --------------------
set heading off;
set feedback off; 
set echo off;
set termout off;
conn SYSTEM/sys as sysdba;
spool D:\Messy\Experiment\大型数据库\OraExp4_D312\cat_output.sql
select 'select * from '||table_name||' where rownum<=5;' from cat where table_name like 'DBA_%';
spool off

-- 执行
start D:\Messy\Experiment\大型数据库\OraExp4_D312\cat_output.sql


-------------------- 生成 SQL 2 --------------------
spool D:\Messy\Experiment\大型数据库\OraExp4_D312\tri_output.sql

select 'alter trigger '||trigger_name||' disable;' from user_triggers;
spool off;

start D:\Messy\Experiment\大型数据库\OraExp4_D312\tri_output.sql

select trigger_name, status from user_triggers;

spool D:\Messy\Experiment\大型数据库\OraExp4_D312\tri_output2.sql
select 'alter trigger '||trigger_name||' enable;' from user_triggers;
spool off;

start D:\Messy\Experiment\大型数据库\OraExp4_D312\tri_output2.sql

```

dbms

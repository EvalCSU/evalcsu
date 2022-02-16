# 实验一、熟悉ORALCE环境并练习SQL操作

[TOC]





## 一、目的与要求

​        本实验主要是熟悉ORACLE的运行环境；建立数据表，并考虑主键、外键及值约束；掌握用户管理及权限控制方法。

## 二、操作环境

- 硬件：主频2GHz以上服务器（内存2GB以上、硬件空闲2.2GB以上），主频1GHz以上微机，内存1GB以上。

- 软件：WINDOWS XP/2000/2003/或Win7/Win8/Win10等。如操作系统是 SERVER版， 可安装ORACLE/9i/10g/11g/12C FOR NT/WINDOWS(注意有32位与64位的区别，可选企业版)； 如果Windows非server如XP/win7等，安装时请选择个人版(PERSONAL)，注意安装时要有兼容性设置与用管理员运行。安装过程中需要关注系统预定义的账号SYS与SYSTEM的密码设置。

## 三、实验内容

### 1. 上机步骤

1. 打开cmd，输入`sqlplus`，然后按提示输入用户名及口令

   ![image-20210923224312648](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210923224312648.png)

2. 在`SQL>`状态下输入建立用户的命令

   ```sql
   CREATE USER C##U_LZC_D312 IDENTIFIED BY sys;
   ```

   查看是否创建成功

   ```sql
   SELECT * FROM all_users WHERE USERNAME='C##U_LZC_D312';
   ```

   ![image-20210923232953403](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210923232953403.png)

3. 给用户授权

   ```sql
   -- 授权
   GRANT resource, connect to C##U_LZC_D312;
   -- 查看当前用户权限：select * from session_privs
   ```

   ![image-20210925011123605](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925011123605.png)

4. 连接用户

   ```sql
   -- 连接
   CONNECT C##U_LZC_D312/sys;
   ```

   ![image-20210925001918529](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925001918529.png)

### 2. 建立表格

#### 2.1 t_major_D312表

```sql
-- 创建表t_major_D312
DROP TABLE t_stud_D312;
DROP TABLE t_major_D312;
CREATE TABLE t_major_D312(
    majorno VARCHAR2(32) PRIMARY KEY,
    mname VARCHAR2(32),
    loc VARCHAR2(32),
    mdean VARCHAR2(32),
    CONSTRAINT loc_ck check(loc in('主校区','南校区','新校区','铁道校区','湘雅校区'))
);
```

![image-20210924170350935](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210924170350935.png)

#### 2.2 t_stud_D312表

```SQL
-- 创建表t_stud_D312
-- DROP TABLE t_stud_D312;
CREATE TABLE t_stud_D312(
    sno VARCHAR2(20) PRIMARY KEY,
    sname VARCHAR2(32),
    sex VARCHAR2(32),
    tel VARCHAR2(32),
    email VARCHAR2(32),
    birthday DATE,
    mno VARCHAR2(20),
    majorno VARCHAR2(32),
    CONSTRAINT sex_ck check(sex in('男', '女', '其它')),
    CONSTRAINT email_ck check(email like '%@%.%'),
    CONSTRAINT birthday_ck check(birthday > TO_DATE('19990731', 'YYYYMMDD')),
    CONSTRAINT majorno_ck check(majorno in substr(sno, 3, 2)),
    CONSTRAINT mno_fk FOREIGN KEY(mno) REFERENCES t_stud_D312(sno),
    CONSTRAINT majorno_fk FOREIGN KEY(majorno) REFERENCES t_major_D312(majorno)
);
```

![image-20210924170239934](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210924170239934.png)

### 3. 插入数据

#### 3.1 插入数据

```sql
insert into t_major_D312 values('00','计科','主校区','王斌');
insert into t_major_D312 values('08','大数据','主校区','廖胜辉');
insert into t_major_D312 values('16','物联网','新校区','彭军');
insert into t_major_D312 values('24','信安','新校区','黄家玮');
 
select * from t_major_D312;
```

![image-20210925002543164](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925002543164.png)

```sql
set serveroutpu on;
declare
	type snoArray     is varray(40) of t_stud_D312.sno%TYPE;
	type snameArray   is varray(40) of t_stud_D312.sname%TYPE;
	type sexArray     is varray(40) of t_stud_D312.sex%TYPE;
	type telArray     is varray(40) of t_stud_D312.tel%TYPE;
	type emailArray   is varray(40) of t_stud_D312.email%TYPE;
	type birthArray   is varray(40) of t_stud_D312.birthday%TYPE;
	type mnoArray     is varray(40) of t_stud_D312.mno%TYPE;
	type majornoArray is varray(40) of t_stud_D312.majorno%TYPE;
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
	
	DELETE FROM t_stud_D312;
	for i in 1..40 loop
		INSERT INTO t_stud_D312 VALUES(snos(i), snames(i), sexes(i), tels(i), emails(i), births(i), mnos(i), majornos(i));
    end loop;
    -- 插入自身数据
    INSERT INTO t_stud_D312 VALUES('8208191312', '李智聪', '男', '17759573563', '1319871052@qq.com', TO_DATE('20010125', 'YYYYMMDD'), '8208190311', '08');
end;
/
```


​	![image-20210925005403791](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925005403791.png)

​	查看插入的数据

```sql
set linesize 500;
SELECT * FROM t_stud_D312;
```

![image-20210925005436670](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925005436670.png)

#### 3. 2 约束测试

```sql
-- 1.主键不为空
insert into t_major_D312(majorno) values('');
 
-- 2.主键不能重复
insert into t_major_D312(majorno) values('00');
insert into t_major_D312(majorno) values('00');
delete from t_major_D312;
 
-- 3.约束：loc范围约束
insert into t_major_D312(loc) values('北校区');
```

![image-20210924101701132](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210924101701132.png)

此时使用`system`管理员对`C##U_LZC_D312`账号进行授权：

```sql
alter user C##U_LZC_D312 quota unlimited on users;
```

再进行`insert`操作

![image-20210924102026497](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210924102026497.png)

```sql
--t_stud_D312约束
-- 1.主键不为空
INSERT INTO t_stud_D312(sno) VALUES('');
 
-- 2.主键不能重复
INSERT INTO t_stud_D312(sno) VALUES('8208191312');
 
-- 3.约束：sex范围约束
INSERT INTO t_stud_D312(sno,sex) VALUES('123456789','?');
 
-- 4.约束：email like '%@%.%'
INSERT INTO t_stud_D312(sno,email) VALUES('123456789','0@2');

-- 5.约束：birthday > to_date('19970731','yyyymmdd')
INSERT INTO t_stud_D312(sno,birthday) VALUES('123456789',to_date('19990101','yyyymmdd'));
 
-- 6.约束：majorno in substr(sno,3,2)
INSERT INTO t_stud_D312(sno,majorno) VALUES('123456789','08');
 
-- 7.外键约束：FOREIGN KEY(mno) REFERENCES t_stud_D312(sno)
INSERT INTO t_stud_D312(sno,mno) VALUES('123456789','1234567891');
 
-- 8.外键约束：FOREIGN KEY(majorno) REFERENCES t_stud_D312(mno)
INSERT INTO t_stud_D312(sno,majorno) VALUES('123456789','87');
```

![image-20210925003140381](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925003140381.png)![image-20210925003514484](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925003514484.png)

### 4. 建立用户及其权限

```sql
-- 首先赋予该用户dba与创建用户权限
CONNECT SYSTEM/sys;
GRANT dba to C##U_LZC_D312;
GRANT CREATE USER TO C##U_LZC_D312;
CONNECT C##U_LZC_D312/sys;
```

![image-20210925011156232](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925011156232.png)

但仍然发现有权限不足的问题，无法创建用户

重启ORACLE服务后即可

```sql
SQLPLUS sys as sysdba;
SHUTDOWN ABORT;
STARTUP;
CONNECT C##U_LZC_D312/sys;
```

![image-20210925092051557](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925092051557.png)

#### 4. 1 创建用户，建立视图并授权

##### 4. 1. 1 每位同学

```sql
set serveroutpu on;
declare
	sno t_stud_D312.sno%TYPE;
	uname varchar2(32);
	-- 创建
	cursor cur_stu is select sno from t_stud_D312;
begin
    -- 打开
	open cur_stu;
	-- 读取
	fetch cur_stu into sno;
	while cur_stu%found loop
		uname := 'C##U_' || sno;
		dbms_output.put_line(uname);
		-- execute immediate 'revoke dba from ' || uname;
		-- execute immediate 'drop user ' || uname || ' cascade';
		
		execute immediate 'create user ' || uname || ' identified by ' || sno;
		
		execute immediate 'grant connect, resource to ' || uname;
		execute immediate 'create view V_' || sno || ' as select * from t_stud_D312 where sno=' || sno;
		execute immediate 'grant select on V_' || sno || ' to ' || uname;
		
		fetch cur_stu into sno;
		-- exception
        -- when others then NULL;
        
    end loop;
    -- 关闭
    close cur_stu;	
    
    -- exception
        -- when others then NULL;
    
end;
/
```

![image-20210925124908944](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925124908944.png)

查看所有用户验证是否创建成功

```sql
SELECT * FROM all_users;
SELECT * FROM TAB;
```

![image-20210925124935915](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925124935915.png)

##### 4. 1. 2 每位班长

```sql
-- 此处发现另外一种可批量操作的方法
set serveroutpu on;
declare
	mno t_stud_D312.mno%TYPE;
	uname varchar2(32);
	-- 创建
	cursor cur_stu2 is select distinct mno from t_stud_D312;
begin
    -- 打开
	open cur_stu2;
	-- 读取
	fetch cur_stu2 into mno;
	while cur_stu2%found loop
		uname := 'C##U_' || mno;
		dbms_output.put_line('V_' || mno);
		execute immediate 'drop view V_' || mno;
		execute immediate 'create view V_' || mno || ' as select * from t_stud_D312 where mno=' || mno;
		execute immediate 'grant select on V_' || mno || ' to ' || uname;
		
		fetch cur_stu2 into mno;
		-- exception
        -- when others then NULL;
        
    end loop;
    -- 关闭
    close cur_stu2;	
    
end;
/
```

![image-20210925140353363](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925140353363.png)

##### 4. 1. 3 专业负责人

```sql
-- 此处发现另外一种批量操作的方法
-- DROP 原有的视图
SELECT 'DROP VIEW V_' || majorno || ';' FROM t_major_D312;

-- copy 输出
DROP VIEW V_00;
DROP VIEW V_08;
DROP VIEW V_16;
DROP VIEW V_24;

-- CREATE USER
SELECT DISTINCT 'CREATE USER C##U_' || majorno || ' IDENTIFIED BY ' || majorno || ';' FROM t_major_D312;
-- copy 输出
CREATE USER C##U_00 IDENTIFIED BY 00;
CREATE USER C##U_24 IDENTIFIED BY 24;
CREATE USER C##U_16 IDENTIFIED BY 16;
CREATE USER C##U_08 IDENTIFIED BY 08;


SELECT 'CREATE VIEW V_' || majorno || ' AS SELECT * FROM t_stud_D312 WHERE majorno=' || majorno || ';' FROM t_major_D312;
-- copy 输出得到
CREATE VIEW V_00 AS SELECT * FROM t_stud_D312 WHERE majorno=00;
CREATE VIEW V_08 AS SELECT * FROM t_stud_D312 WHERE majorno=08;
CREATE VIEW V_16 AS SELECT * FROM t_stud_D312 WHERE majorno=16;
CREATE VIEW V_24 AS SELECT * FROM t_stud_D312 WHERE majorno=24;


SELECT 'GRANT CONNECT, resource TO C##U_' || majorno || ';' FROM t_major_D312;
-- copy 输出
GRANT CONNECT, resource TO C##U_00;
GRANT CONNECT, resource TO C##U_08;
GRANT CONNECT, resource TO C##U_16;
GRANT CONNECT, resource TO C##U_24;

SELECT 'GRANT SELECT ON V_' || majorno || ' TO C##U_' || majorno || ';' FROM t_major_D312;

-- copy 输出
GRANT SELECT ON V_00 TO C##U_00;
GRANT SELECT ON V_08 TO C##U_08;
GRANT SELECT ON V_16 TO C##U_16;
GRANT SELECT ON V_24 TO C##U_24;
```

![image-20210925142411485](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925142411485.png)

#### 4. 2查询测试

##### 4. 2. 1每位同学只能查询自己的信息

```sql
CONNECT C##U_8208191312/8208191312;
SELECT * FROM C##U_LZC_D312.V_8208191312; 
-- 注意此处一定要加上这个C##U_LZC_D312.,否则仍然查询不到
```

![image-20210925134231971](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925134231971.png)

```SQL
-- 尝试查询别的同学
SELECT * FROM C##U_LZC_D312.V_8208190340;
```

![image-20210925134842454](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925134842454.png)

##### 4. 2. 2 班长只能查询本班的信息

```sql
CONNECT C##U_8216190321/8216190321;
SELECT * FROM C##U_LZC_D312.V_8216190321; 
```

![image-20210925140518454](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925140518454.png)

```SQL
-- 尝试查询别班
SELECT * FROM C##U_LZC_D312.V_8200190301;
```

![image-20210925140621549](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925140621549.png)

##### 4. 2. 3 专业负责人只能查询本专业的同学

```sql
CONNECT C##U_00/00;
SELECT * FROM C##U_LZC_D312.V_00; 
```

![image-20210925142432877](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925142432877.png)

```sql
-- 尝试查询别的专业
SELECT * FROM C##U_LZC_D312.V_08; 
```

![image-20210925142501093](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20210925142501093.png)

## 5. 收获

- 创建表格时关于`loc`的范围约束可以考虑使用`in`关键字
- 插入数据时一直想调研如何实现批量插入，知道肯定往过程方面去想，但缺少一种类似数组的数据结构。搜索后发现有`varray`这种数据类型。具体些代码时涉及到大量关于`Oracle`基本数据结构的基本操作，例如`TO_CHAR()`，`TO_DATE`，`||`等等，以及一些流程语句，例如`CASE语句`，`while循环`，`for循环`；其中为了调试还学习了`Oracle`的一些输出函数以及终端参数设置。其实可以不用数组存储，但为了学习`varray`数据结构，所以最终采用`varray`的方法。
- 创建用户与视图时除了上述利用过程实现批量操作外涉及到**动态创建与执行`SQL`语句`execute immediate`**，它解析并马上执行动态的SQL语句或非运行时创建的PL/SQL块；此外也用到了**游标**的知识，处理每一行数据。
- 关于批量操作与同学探讨后发现可以采取`select`语句打印出命令再粘贴到命令行，然后执行，这样也可以解决，但人参与的内容过多，比较繁琐，但代码易调试。
- 整个实验过程经常涉及到权限的问题，例如创建用户权限，发现及时授予该权限，仍无法创建用户，上网查询后发现通过`shutdown abort`和`startup`重启`Oracle`服务即可，但其中原因仍不清楚。

- 学到了一些其他的操作，例如查看当前所有的用户，查看当前用户创建的所有表格，查看当前用户的所有权限等等

## 6. 代码清单(可单独见附件一)

```sql
-- 1. 创建用户并授权，连接
-- 创建用户
CREATE USER C##U_LZC_D312 IDENTIFIED BY sys;
-- 查看是否创建成功
SELECT * FROM all_users WHERE USERNAME='C##U_LZC_D312';
-- 授权
GRANT resource, connect to C##U_LZC_D312;
-- 查看当前用户权限：select * from session_privs
-- 连接
CONNECT C##U_LZC_D312/sys;

-------------------------------------------------

-- 2. 1创建表t_major_D312
DROP TABLE t_stud_D312;
DROP TABLE t_major_D312;
CREATE TABLE t_major_D312(
    majorno VARCHAR2(32) PRIMARY KEY,
    mname VARCHAR2(32),
    loc VARCHAR2(32),
    mdean VARCHAR2(32),
    CONSTRAINT loc_ck check(loc in('主校区','南校区','新校区','铁道校区','湘雅校区'))
);

-- 2. 2创建表t_stud_D312
-- DROP TABLE t_stud_D312;
CREATE TABLE t_stud_D312(
    sno VARCHAR2(20) PRIMARY KEY,
    sname VARCHAR2(32),
    sex VARCHAR2(32),
    tel VARCHAR2(32),
    email VARCHAR2(32),
    birthday DATE,
    mno VARCHAR2(20),
    majorno VARCHAR2(32),
    CONSTRAINT sex_ck check(sex in('男', '女', '其它')),
    CONSTRAINT email_ck check(email like '%@%.%'),
    CONSTRAINT birthday_ck check(birthday > TO_DATE('19990731', 'YYYYMMDD')),
    CONSTRAINT majorno_ck check(majorno in substr(sno, 3, 2)),
    CONSTRAINT mno_fk FOREIGN KEY(mno) REFERENCES t_stud_D312(sno),
    CONSTRAINT majorno_fk FOREIGN KEY(majorno) REFERENCES t_major_D312(majorno)
);

--------------------------------------------------

-- 3. 1 插入数据
insert into t_major_D312 values('00','计科','主校区','王斌');
insert into t_major_D312 values('08','大数据','主校区','廖胜辉');
insert into t_major_D312 values('16','物联网','新校区','彭军');
insert into t_major_D312 values('24','信安','新校区','黄家玮');
 
select * from t_major_D312;

set serveroutpu on;
declare
  type snoArray     is varray(40) of t_stud_D312.sno%TYPE;
  type snameArray   is varray(40) of t_stud_D312.sname%TYPE;
  type sexArray     is varray(40) of t_stud_D312.sex%TYPE;
  type telArray     is varray(40) of t_stud_D312.tel%TYPE;
  type emailArray   is varray(40) of t_stud_D312.email%TYPE;
  type birthArray   is varray(40) of t_stud_D312.birthday%TYPE;
  type mnoArray     is varray(40) of t_stud_D312.mno%TYPE;
  type majornoArray is varray(40) of t_stud_D312.majorno%TYPE;
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
  
  DELETE FROM t_stud_D312;
  for i in 1..40 loop
    INSERT INTO t_stud_D312 VALUES(snos(i), snames(i), sexes(i), tels(i), emails(i), births(i), mnos(i), majornos(i));
    end loop;
    -- 插入自身数据
    INSERT INTO t_stud_D312 VALUES('8208191312', '李智聪', '男', '17759573563', '1319871052@qq.com', TO_DATE('20010125', 'YYYYMMDD'), '8208190311', '08');
end;


-- 查看插入的数据
set linesize 500;
SELECT * FROM t_stud_D312;


-- 3. 2 约束测试
-- t_major_D312约束
-- 1.主键不为空
insert into t_major_D312(majorno) values('');
 
-- 2.主键不能重复
insert into t_major_D312(majorno) values('00');
insert into t_major_D312(majorno) values('00');
delete from t_major_D312;
 
-- 3.约束：loc范围约束
insert into t_major_D312(loc) values('北校区');


--t_stud_D312约束
-- 1.主键不为空
INSERT INTO t_stud_D312(sno) VALUES('');
 
-- 2.主键不能重复
INSERT INTO t_stud_D312(sno) VALUES('8208191312');
 
-- 3.约束：sex范围约束
INSERT INTO t_stud_D312(sno,sex) VALUES('123456789','?');
 
-- 4.约束：email like '%@%.%'
INSERT INTO t_stud_D312(sno,email) VALUES('123456789','0@2');

-- 5.约束：birthday > to_date('19970731','yyyymmdd')
INSERT INTO t_stud_D312(sno,birthday) VALUES('123456789',to_date('19990101','yyyymmdd'));
 
-- 6.约束：majorno in substr(sno,3,2)
INSERT INTO t_stud_D312(sno,majorno) VALUES('123456789','08');
 
-- 7.外键约束：FOREIGN KEY(mno) REFERENCES t_stud_D312(sno)
INSERT INTO t_stud_D312(sno,mno) VALUES('123456789','1234567891');
 
-- 8.外键约束：FOREIGN KEY(majorno) REFERENCES t_stud_D312(mno)
INSERT INTO t_stud_D312(sno,majorno) VALUES('123456789','87');

-- 4. 建立用户及其权限
-- 首先赋予该用户dba与创建用户权限
CONNECT SYSTEM/sys;
GRANT dba to C##U_LZC_D312;
GRANT CREATE USER TO C##U_LZC_D312;
CONNECT C##U_LZC_D312/sys;

-- 4. 1. 1每位同学
set serveroutpu on;
declare
  sno t_stud_D312.sno%TYPE;
  uname varchar2(32);
  -- 创建
  cursor cur_stu is select sno from t_stud_D312;
begin
    -- 打开
  open cur_stu;
  -- 读取
  fetch cur_stu into sno;
  while cur_stu%found loop
    uname := 'C##U_' || sno;
    dbms_output.put_line(uname);
    -- execute immediate 'revoke dba from ' || uname;
    -- execute immediate 'drop user ' || uname || ' cascade';
    
    execute immediate 'create user ' || uname || ' identified by ' || sno;
    
    execute immediate 'grant connect, resource to ' || uname;
    execute immediate 'create view V_' || sno || ' as select * from t_stud_D312 where sno=' || sno;
    execute immediate 'grant select on V_' || sno || ' to ' || uname;
    
    fetch cur_stu into sno;
    -- exception
        -- when others then NULL;
        
    end loop;
    -- 关闭
    close cur_stu;  
    
    -- exception
        -- when others then NULL;
    
end;


-- 查看是否创建成功
SELECT * FROM all_users;
SELECT * FROM TAB;

-- 4. 1. 2每位班长
-- 此处发现另外一种可批量操作的方法
set serveroutpu on;
declare
  mno t_stud_D312.mno%TYPE;
  uname varchar2(32);
  -- 创建
  cursor cur_stu2 is select distinct mno from t_stud_D312;
begin
    -- 打开
  open cur_stu2;
  -- 读取
  fetch cur_stu2 into mno;
  while cur_stu2%found loop
    uname := 'C##U_' || mno;
    dbms_output.put_line('V_' || mno);
    execute immediate 'drop view V_' || mno;
    execute immediate 'create view V_' || mno || ' as select * from t_stud_D312 where mno=' || mno;
    execute immediate 'grant select on V_' || mno || ' to ' || uname;
    
    fetch cur_stu2 into mno;
    -- exception
        -- when others then NULL;
        
    end loop;
    -- 关闭
    close cur_stu2; 
    
end;

-- 4. 1. 3专业负责人
-- 此处发现另外一种批量操作的方法
-- DROP 原有的视图
SELECT 'DROP VIEW V_' || majorno || ';' FROM t_major_D312;

-- copy 输出
DROP VIEW V_00;
DROP VIEW V_08;
DROP VIEW V_16;
DROP VIEW V_24;

-- CREATE USER
SELECT DISTINCT 'CREATE USER C##U_' || majorno || ' IDENTIFIED BY ' || majorno || ';' FROM t_major_D312;
-- copy 输出
CREATE USER C##U_00 IDENTIFIED BY 00;
CREATE USER C##U_24 IDENTIFIED BY 24;
CREATE USER C##U_16 IDENTIFIED BY 16;
CREATE USER C##U_08 IDENTIFIED BY 08;


SELECT 'CREATE VIEW V_' || majorno || ' AS SELECT * FROM t_stud_D312 WHERE majorno=' || majorno || ';' FROM t_major_D312;
-- copy 输出得到
CREATE VIEW V_00 AS SELECT * FROM t_stud_D312 WHERE majorno=00;
CREATE VIEW V_08 AS SELECT * FROM t_stud_D312 WHERE majorno=08;
CREATE VIEW V_16 AS SELECT * FROM t_stud_D312 WHERE majorno=16;
CREATE VIEW V_24 AS SELECT * FROM t_stud_D312 WHERE majorno=24;


SELECT 'GRANT CONNECT, resource TO C##U_' || majorno || ';' FROM t_major_D312;
-- copy 输出
GRANT CONNECT, resource TO C##U_00;
GRANT CONNECT, resource TO C##U_08;
GRANT CONNECT, resource TO C##U_16;
GRANT CONNECT, resource TO C##U_24;

SELECT 'GRANT SELECT ON V_' || majorno || ' TO C##U_' || majorno || ';' FROM t_major_D312;

-- copy 输出
GRANT SELECT ON V_00 TO C##U_00;
GRANT SELECT ON V_08 TO C##U_08;
GRANT SELECT ON V_16 TO C##U_16;
GRANT SELECT ON V_24 TO C##U_24;

-- 4. 2查询测试

-- 4. 2. 1 普通同学
CONNECT C##U_8208191312/8208191312;
SELECT * FROM C##U_LZC_D312.V_8208191312; 
-- 注意此处一定要加上这个C##U_LZC_D312.,否则仍然查询不到

-- 尝试查询别的同学
SELECT * FROM C##U_LZC_D312.V_8208190340;

-- 4. 2. 2 班长
CONNECT C##U_8216190321/8216190321;
SELECT * FROM C##U_LZC_D312.V_8216190321; 

-- 尝试查询别班
SELECT * FROM C##U_LZC_D312.V_8200190301;

-- 4. 2. 3 专业负责人
CONNECT C##U_00/00;
SELECT * FROM C##U_LZC_D312.V_00; 
-- 尝试查询别的专业
SELECT * FROM C##U_LZC_D312.V_08; 
```

## 7. 参考网站

[varray_1](https://www.cnblogs.com/qianwen/p/3771340.html)

[varray_2](https://blog.csdn.net/ageeklet/article/details/83055096)

[时间操作](https://blog.csdn.net/whhitgen/article/details/8793571)


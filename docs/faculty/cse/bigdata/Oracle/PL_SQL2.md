# PL/SQL2

## 游标

### 1. 显式游标

#### 1. 1 声明游标

```plsql
cursor cur_xxx 
[(
	para1, 
    para2
)]
[return ret_type]
is select_sentence;

-- para 分为四部分
-- 1. 变量名
-- 2. in 表示方向，可省略
-- 3. 变量类型，不可指定长度
-- 4. 默认值，可省略，可用:= 或 default 赋值
-- para例子
var_xxx int:=100

-- 带参数游标例子
cursor cur_xxx
(
    p_major t_stud_major%type
) 
is
select ... from t_stud where major=p_major;

open cur_xxx('math')
loop 
	fetch cur_xxx into ...;
	exit when cur_xxx%notfound;
	...
end loop;
close cur_xxx;

```

#### 1. 2 打开游标

打开游标就是执行定义的`select`语句，执行完成后将结果装入内存，游标停在首行，注意不是第一行

```plsql
open cur_xxx(value1, ...)

-- eg
open cur_xxx('abc')
```

若指定了默认值，则可不传入

#### 1. 3 读取游标

```plsql
fetch cur_xxx into {var}

var指一个变量列表或记录型变量(record类型)
```

#### 1. 4 关闭游标

```plsql
close cur_xxx;
```

### 2. 隐式游标

在执行一个SQL语句时(`update`,`insert`, `delete`)，会默认创建一个隐式游标`SQL`

无论是显式游标还是隐式游标，它们的属性总是反映最近一条SQL语句的处理结果。因此当有多条SQL语句时，游标的属性值只能反映出紧挨着它上一条SQL语句的处理结果

### 3. select for update 游标

select语句部分如下这样写即可

```plsql
select ... from ...
for update [of col1, col2][nowait]

-- 这样就可以针对性地针对当前行进行更新操作
for xxx in cur_xxx loop
	update t_xxx 
	set ...
    where current of cur_xxx;
end loop;
```

### 4. 游标属性

- `%FOUND`
- `%NOTFOUND`
- `%ROWCOUNT`：返回受SQL语句影响的行数
- `%ISOPEN`

### 5. 通过 FOR 语句循环游标

#### 5. 1 遍历隐式游标的数据

```plsql
for xxx in (select sno, sname from...)
loop
	... -- 通过xxx.sno xxx.sname访问值
end loop;
```

#### 5. 2 遍历显示游标的数据

```plsql
cursor cur_xxx is select * from t_xxx;
-- 法一
for xxx in cur_xxx
loop
	...
end loop;

-- 法二
open cur_xxx
loop
	fetch cur_xxx into ...
	exit when cur_xxx%notfound
	...
end loop;
close cur_xxx;
```

### 6. 游标变量

类似于高级语言中的指针

#### 6. 1 定义游标变量类型

```plsql
-- 受限游标变量类型
type type_xxx is ref cursor
return <返回类型>;

返回类型必须是一个记录类型
效果相当于返回<返回类型>的引用，类似于int&

-- 非受限游标变量类型
type type_xxx is ref cursor;

一个非受限游标变量可以为任意查询打开
```

#### 6. 2 声明游标变量

```plsql
xxx type_xxx ;
```

#### 6. 3 打开游标变量

```plsql
open xxx for select...
```

#### 6. 4 关闭游标变量

```plsql
close xxx;
```

## 过程

```plsql
create [or replace] procedure pro_xxx 
[(
	[para1 in | out | in out int]
	[,para2 in | out | in out varchar2]...
)]
IS | AS
[内部变量;]
begin
	...;
[exception]
	...;
end [pro_xxx];
```

PS:

- `in`理解为形参，`out`理解为这个参数**在过程外面的PL/SQL语句被定义**然后传入，**会在过程中被赋值**，然后会return这个参数
- `in`, `out`后面跟上数据类型，但**不能指定长度**
- `para1`, `para2`是形参，不是存储过程的局部变量；局部变量需在`IS|AS`关键字后定义，并用分号结束
- `IS`与`AS`是完全相同的功能，可以替换
- 在`SQL*Plus`环境中，使用`EXECUTE pro_xxx`执行存储过程/`EXEC`也可以吧，对`in`, `out`都可以吧
- 可用`DESC`命令查看存储过程中的参数定义信息
- 可使用`PRINT var1 var2 ...` 输出绑定的变量值
- 可使用`SELECT :var1, :var2 FROM dual` 输出绑定的变量值 

### 1. In 模式参数

指定名称传递（此时可打乱顺序）：`pro_xxx(para1=>value1, para2=>value2)`

混合方式传递：在某个位置使用在“指定名称传递”方式传入参数值后，后面的参数都必须使用“指定名称传递”

### 2. Out 模式参数

### 3. In Out 模式参数

要求在过程块外定义，然后传入`pro_xxx`

### 4. In 模式参数的默认值

类似`para1 int default 100`

此时建议按指定名称传递

### 5. 删除过程

```plsql
drop procedure pro_xxx;
```

## 函数

函数一般用于计算和返回一个值，可像编程语言一样作为表达式的一部分；而过程的调用是一条PL/SQL语句

函数必须要有一个返回值，而过程则没有

```plsql
-- 创建函数
create [or replace] function fun_xxx
(
	x1 int,
    x2 char
)
return varchar2
is
[declare_var;]
begin
	...
	return ...;
[exception]
	when no_data_found then
	return -1;
end;


-- 调用函数
declare
	avg_pay number;
begin
	avg_pay := fun_xxx(10);
end;

-- 删除函数
drop function fun_xxx;
```

## 触发器

```plsql
create [or replace] trigger tri_xxx
[before | after | instead of] tri_event
on table_xxx | view_xxx | user_xxx db_xxx
[for each row [when tri_condition]]
 
 declare
 ...
 begin
 	...;
 end [tri_xxx];
```

PS:

- 没有用到`is`关键字

- `instead of`表示...

- `tri_event`有多个的话用`or`隔开，例如：`before insert or update`

- 若有多个`tri_event`，需要分情况处理时，可使用

- `tri_condition`是一个布尔表达式，对每一行进行求值。触发器只对那些满足`WHEN`子句指定的条件的行进行处理；`:new`和`:old`也可以在`tri_condition`内部使用，但不需要使用冒号

  ```plsql
  if inserting then
  	...;
  elsif updating then
  	...;
  elsif deleting then
  	...;
  end if;
  
  -- 甚至可以这样: 若更新某列则...
  if updating(col_name) then
  	...
  end if;
  ```

### 1. 语句级触发器

对每一条SQL语句，若触发的话，只执行一次

```plsql
没有 for each row 子句
```

### 2. 行级触发器

针对每一个DML语句所影响的每一行都执行一次触发操作

```plsql
必须有 for each row 子句
```

针对行级触发器，还有**列标识符**关键字

```plsql
:new.col_name(如:new.id): 指向当前新行的col_name值
:old.col_name(如:old.id): 指向当前旧行的col_name值

给:new.id赋值相当于给当前行的id赋值，即相当于update效果
:new.id 通常在insert与update语句中被使用
:old.id 通常在update与delete语句使用
```

### 3. 替换触发器

定义在视图上；用于解决如下问题

由于视图是由**多个基表**连接组成的逻辑结构，所以一般不允许用户执行DML操作

必须是行级触发器

```plsql
使用 instead of 关键字

create trigger tri_xxx 
instead of delete on t_xxx
for each row
begin
	...
end tri_xxx;
```

### 4. 用户事件触发器

是指由于用户登录、退出或DDL操作而引起运行的一种触发器

```plsql
create or replace trigger tri_xxx
before create or alter or drop 
on user_xxx.schema
```

具体见P209范例

### 5. 删除触发器

```plsql
drop trigger tri_xxx;
```

### 6. 触发器的激发

```plsql
-- 禁止激发
alter trigger tri_xxx [disable | enable];

-- 禁止表上的所有触发器
alter table t_xxx disable all trigger;
```

激发顺序

- before 语句级
- 对于受影响的每一行
  - befor 行级
  - dml
  - after 行级
- after 语句级

## 程序包

类似Python的模块：`dbms_output.put_line()`

PS：创建顺序不能调换

### 1. 创建程序包的规范

```plsql
create [or replace] package pack_xxx 
is
-- declare_var
-- declare_type
-- declare_cursor
function fun_xxx(x int) return char;
procedure pro_xxx(x in int);
end [pack_xxx];
```

### 2. 创建程序包的主体

```plsql
create [or replace] package body pack_xxx 
is
-- inner_var
-- cursor_body
	function fun_xxx(x int) return char
		is
		... -- 就是创建函数的语法去掉create，其余**一模一样**
	procedure pro_xxx(x in int) 
		is
		... -- 就是创建过程的语法去掉create，其余**一模一样**
	...
end [pack_xxx];
```

### 3. 调用

```plsql
pack_xxx.xxx
```

### 4. 删除包

```plsql
drop package p
```

## 异常

异常包括预定义异常与用户自定义异常

用户定义的异常必须用`raise`显示提出

用户自定义异常必须在PL/SQL块的声明部分进行声明。声明语法与变量声明类似

`others`关键字指代其他异常

```plsql
declare 
	exception_xxx exception;
begin
	if condition then
		rasie exception_xxx;
	end if;
exception
	when exception_xxx then
	...;
	when others then
	...;
end;
```

### 1. 定义异常

```plsql
-- 用户自定义异常
exception_xxx exception;

-- 为内部异常命名
prage exception_init(exception_xxx, Oracle错误号);
```

### 2. 抛出异常

- 运行时PL/SQL自动抛出
- `raise exception_xxx`
- 调用存储过程`raise application_error(err_num, err_msg[, kepp_errors])`

## 补充

### 1. 操作

```plsql
-- 保留整数
select round(1.55) from dual; -- 2
select ceil(1.55) from dual;  -- 2
select floor(1.55) from dual; -- 1
-- 随机打乱
select distinct last_name from t_name1 order by dbms_random.value)
-- [1,1000)随机选一个小数
select dbms_random.value(1,1000) into v_num from dual;
-- [0, 1)随机选一个小数
select dbms_random.value into v_num from dual;
-- [-power(2,31) pow(2,31)) 随机选一个整数
select DBMS_RANDOM.RANDOM from dual;
-- 转换函数
select cast(1 as varchar2(32)) from dual;	
select cast('1' as number) from dual;	
select to_date('20010125', 'yyyymmdd') from dual;
```

### 2. SQL PLUS 常见操作

```plsql
set serveroutpu on;
set timing on;
set linesize 500;
set autotrace on;
col sno format a5;
col grade format 999;
```




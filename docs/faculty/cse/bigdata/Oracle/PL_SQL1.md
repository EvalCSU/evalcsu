# PL/SQL 1

## 结构

```plsql
declare
	-- 变量声明
	var int:=0;
	var int default 0;
	var constant int:=0;
begin
	-- 语句
exception
	-- 异常处理
end;
```

- 声明里面可初始化
- **变量不区分大小写**
- 异常是可选的
- 每一句都必须以`;`结束
- 注释的两种方式：--    /**/
- 几种变量赋值方式
  - `:=`或`default`
  - `select into`
  - `fetch into`

## 数据类型

### 1. 标量数据类型

- 数字`number`
- 字符`character`
- 日期`date`
- 布尔`boolean`
- 行标识`rowid`
- 原族`raw`

查询`rowid`: `select rowid from t_xxx`

### 2. 大型数据类型

用于存储图像声音等大型数据对象LOB

LOB可以是二进制数据，也可以是字符数据，最大长度不超过4G

LOB数据类型分为BFILE BLOB CLOB NCLOB

BFILE例子见PPT

### 3. 复合数据类型

#### 3. 1 记录类型

```plsql
declare
	type rec_xxx is record
	(
        sno int,
        sname varchar2(32)
    );
    v_stu_info rec_xxx;
begin
	v_stu_info.sno := 1;
	v_stu_info.sname := 'Alex'
end;

-- 或者
declare
	v_stu_info t_xxx%rowtype;
begin
	select * into v_stu_info from t_xxx where sno=100;
end;

```

#### 3. 2 表类型

有两列：`key` `value`

`key`类型是BINARY_INTEGER

`value`类型是在定义中指定的类型

```plsql
declare
	type table_xxx is table of varchar2(32) index by binary_integer;
	type table_xxx2 is table of t_xxx%rowtype index by binary_integer
	v_name table_xxx;
	v_stu table_xxx2;
	
begin
	v_name(-4):='Alex';
	
	select * into v_name(1001) from table_xxx where sno = 100;
	v_name(1001).sname = 'Rosie'
end;
```

批量注入

```plsql
set serveroutpu on;
declare 
	type t_attendTable is table of t_attend%rowtype index by binary_integer;
	
	v_attend t_attendTable;
begin
	select * bulk collect into v_attend from t_attend where majorno='08' and rownum<=3;
	dbms_output.put_line(v_attend(1).sno); -- 下标从1开始
end;
```

**表的属性**

**只能用于table数据类型**

- count：返回表的行数
- delete：从表中删除元素
- exists：当表存在索引i，表名.exists(i)返回true
- first：返回表的第一个元素的索引（第一个元素被定义为拥有最小索引值的元素，最后一个元素是拥有最大索引值的元素）
- last：...
- next：返回表的下一个元素的索引；可以用来遍历表
- prior：...

## PL/SQL 控制结构

```plsql
-- 分支
if xxx then
	...
elsif xxx then
	...
else
	...
end if; -- 注意不是endif!!!

-- loop循环
loop 
	...
exit when xxx
	...
end loop;

-- while循环
while xxx loop
	...
end loop;

-- for循环
for i in [reverse] 1..100 loop -- i不需要显示定义
	dbms_output.put_line(i);
end loop;


-- goto语句
...
goto label;
...
<<label>>
...
```

##  伪列

- `ROWID`

- `ROWNUM`：在查询中返回当前的行序号；常用于限制要处理的行的总数

  `select * from t_xxx where rownum <= 3 order by last_name`

- `LEVEL`：仅用在对标执行层次树遍历的select语句

  层次树遍历的select语句指的是使用`start with`和`connect by`子句定义的select语句

  根节点的level值为1，一级子结点的level值为2，以此类推

- `CURRVAL`和`NEXTVAL`



关于 level 的解释

```plsql
select level, ... from ...
start with job_id='FI_MGR' -- 指定成为根节点的条件
connect by prior employee_id=manage_id -- 对每一个根节点指定能够成为叶节点的节点
-- level 记录当前遍历到的节点是属于哪一层，从1开始（可以理解为自动增长）

假设表 t 只有一个id列，存了三行，分别是A B C
select id,level from t connect by level < 3;
-- 谁成为根节点？没有start with，所以 A B C 均成为根节点，所以一共有三棵树
-- 谁成为叶节点？connect by 没有限制成为叶节点的条件，所以都可以成为叶节点
-- 直到深度到达2为止
-- 结果如下面第一张图

select id,level from t connect by level<4;
-- 结果如下面第二张图
```

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202112161524886.png" alt="image-20211216152415823" style="zoom:67%;" />

<img src="https://img-blog.csdn.net/20180115174727350?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvendqenFxYg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast" alt="img" style="zoom:80%;" />

即

思考顺序：**谁成为根？--> 对每个根来说，谁可以成为叶子结点？ --> 依次递归**

伪列 level 必须和 connect by 一起使用

connect by 后面是一个条件语句，为真则继续

本例讨论的是 connect by level < h，而非 connect by level< = h（实际上就是相差1的区别）
有些时候伪列 level 和 rownum 可以做替换使用
该 sql 会生成树形结构
t 表中有 N 条数据，则生成 N 个子树
每个子树有 h-1 层，即高度为 L=h-1，查出的数据中level的值最大为 h-1
对于同一层的叶子结点，sql 查出来的记录顺序是生成的子树以**先根遍历**的顺序
当 h 为 1 或者 2 时，子树的高度都为 1（因为没有高度为0的树），SQL 查询结果就是 t 表的所有记录

返回的记录记录在一张表中

```plsql
select 节点 from 表 start with 根节点 connect by 布尔表达式

-- 等价于
void dfs(root) {
	while 布尔表达式 loop
        get all records which meet 布尔表达式 into nodes
        for node in nodes loop
            print(node)
            dfs(node)
        end loop
	end loop;
}

```



参考[此处](https://blog.csdn.net/zwjzqqb/article/details/79066224)

## Returning 子句

一般用在PL/SQL程序中获取DML操作的返回值

- `insert`: 返回添加的记录的字段值
- `update`: 返回更新后的记录的字段值
- `delete`: 返回删除前的记录的字段值

不需要再次通过select语句获取记录值，提高了效率

```plsql
update t_xxx set score = score + 1 where id=1 returning score into v_xxx;
delete from classes where department='CS' returning col1, col2 into v1, v2;
```

## 常见数据操作

[官方文档](https://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements004.htm#i34510)

### 1. 日期

`birthday > TO_DATE('19990731', 'YYYYMMDD')`

转换为日期

```plsql
TO_DATE('20010101', 'YYYYMMDD')
```

### 2. 字符串

转换为字符串

```plsql
-- 前导0
select to_char(9,'09') from dual;
-- 日期转换为字符串
select sysdate from dual;
SYSDATE
--------------
22-12月-21
select to_char(sysdate, 'dd-mm-yy') from dual;
TO_CHAR(
--------
22-12-21
```



## 

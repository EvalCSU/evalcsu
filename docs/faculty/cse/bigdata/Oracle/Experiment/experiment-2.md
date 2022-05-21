# 实验二、编写ORALCE触发器与过程



[TOC]

























## 一、目的与要求

​        本实验主要是熟悉ORACLE的后台编程，包括触发器与过程的编制，可比较基于SQL Server的触发器与过程。

## 二、操作环境

- 硬件：主频2GHz以上服务器（内存2GB以上、硬件空闲2.2GB以上），主频1GHz以上微机，内存1GB以上。

- 软件：WINDOWS XP/2000/2003/或Win7/Win8/Win10等。如操作系统是 SERVER版， 可安装ORACLE/9i/10g/11g/12C FOR NT/WINDOWS(注意有32位与64位的区别，可选企业版)； 如果Windows非server如XP/win7等，安装时请选择个人版(PERSONAL)，注意安装时要有兼容性设置与用管理员运行。安装过程中需要关注系统预定义的账号SYS与SYSTEM的密码设置。

## 三、实验内容

### 1. 设计考勤表

设计与建立上课考勤表Attend，能登记每个学生的考勤记录包括正常、迟到、旷课、请假。能统计以专业为单位的出勤类别并进行打分评价排序，如迟到、旷课、请假分别扣2，5，1分。可以考虑给一值，以免负值

考虑设计一个附表`t_status_score_map_D312`，用来映射出勤类别到分值，表字段如下图示：

| STATUS | SCORE |
| :----: | :---: |
|        |       |

PS: 这里我们创建一个同义词对象`t_map`为方便操作，然后进行`insert`操作

![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081412897.jpg)

接下来设计t_Attend_D312

| SNO  | MAJOR_NO | CLASS_DATE | PERIOD | STATUS |
| :--: | :------: | :--------: | :----: | :----: |
|      |          |            |        |        |

PS: 这里我们创建一个同义词对象`t_attend`为方便操作

![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081412130.jpg)

### 2. 增加出勤打分汇总字段

为`major`表与`stud`表增加`sum_evaluation`数值字段，以记录根据考勤表Attend中出勤类别打分汇总的值

为防止出现负值，这里分别设置初始值为100与1000

![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081412553.jpg)![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081412909.jpg)

### 3. 建立考勤汇总表

建立个人考勤汇总表`stud_attend`与专业考勤表`major_attend`，表示每个学生或每个专业在某时间周期（起始日期，终止日期）正常、迟到、旷课、请假次数及考勤分值

由于没有足够的背景信息，为防止出现歧义，==在这里我们做如下假设==：

- 时间区间相关字段都是事先统一的，各个区间是互斥的，不会存在有交集的情况
- major表的`sum_evaluation`字段存的是全时间段的分值，默认值也就是上个步骤的1000，且只会在每个学期末生成一次该学期的时间区间的分数（通过第六步的存储过程生成），同一时间段同一专业不会进行二次更新（这是因为由于major表没有时间区间字段，说明统计的是整个时间轴/所有学期的考勤分，而第六步存储过程要求传入起始时间以及结束时间，生成该时间段的汇总信息；若同一时间段同一专业可以多次更新，那么会重复减去一些分数）
- major_attend的`loss-score`字段存的是某时间段的扣除信息，默认值就是0
- stud_attend的`score`字段存的是某时间段的得分情况

个人考勤汇总表`t_stud_attend_D312`设计如下

| SNO  | SNAME | START_DATE | END_DATE | ARRIVED | LATE | ABSENTEEISM | LEAVE | SCORE |
| :--: | :---- | :--------: | :------: | :-----: | :--- | :---------: | :---: | :---: |
|      |       |            |          |         |      |             |       |       |

专业考勤表`t_major_attend`设计如下

| MAJORNO | START_DATE | END_DATE | ARRIVED | LATE | ABSENTEEISM | LEAVE | LOSS_SCORE |
| :-----: | :--------: | :------: | :------ | :--- | :---------- | :---- | :--------- |
|         |            |          |         |      |             |       |            |

![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081412625.jpg)![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081412240.jpg)![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081412252.jpg)

PS: 这里同样创建同义词对象`t_stud_attend`与`t_major_attend`为方便操作

### 4. 插入样本

根据major表中的值与stud中的值，为考勤表Attend输入足够的样本值，要求每个专业都要有学生，有部分学生至少要有一周的每天5个单元（12，34，56，78，90，没有课的单元可以没有考勤记录）的考勤完整记录，其中正常、迟到、旷课、请假 可以用数字或字母符号表示。

![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081412724.jpg)

### 5. 建立触发器

建立触发器，当对考勤表Attend表进行相应插入、删除、修改时，对stud表的`sum_evaluation` 数值进行相应的数据更新

如果是插入操作，则`sum_evaluation`减去对应的扣分值

如果是删除操作，则`sum_evaluation`加去对应的扣分值

如果是更新操作，则`sum_evaluation`加上旧记录的扣分值再减去新记录的扣分值

![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081413756.jpg)

下面分别进行三种操作验证结果

1. 插入操作

   插入一条旷课记录，可以看到该学生`sum_evaluation`=95

   ![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081413773.jpg)

2. 更新操作

   将上面旷课的学生的记录改为请假，可以看到该学生`sum_evaluation`=95+5-1=99

   ![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081413001.jpg)

3. 删除操作

   删去上面该学生的旷课记录，可以看到`sum_evaluation`=99+1=100

   ![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081413803.jpg)

### 6. 建立过程

建立过程，生成某专业某时段（起、止日期）的考勤汇总表`major_attend`中各字段值，并汇总相应专业，将考勤分值的汇总结果写入到`major`表中的`sum_evaluation`中

前提：现在已经做到，每次只操作t_attend表，通过上一步的触发器会自动更新t_stud表。现要求做到可以更新某一专业某一时间段的统计信息操作

即

通过遍历t_attend表中的有关字段
得到正常，迟到，请假，旷课次数的计
从而更新汇总major表与major_attend表的统计信息字段

![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081413846.jpg)

检验：在这里生成2021-09-01到2022-01-22的大数据专业的考勤表记录

![avatar](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202081413974.jpg)



## 四、收获

- 印象最深刻的是最后一步创建存储过程由于传入的参数major与t_major_D312的major字段同名，一直导致最后的update操作出现问题（对所有专业update），改了许久才发现这个错误
- 此外发现在PL/SQL中不能直接使用select查询语句，而应该加上`execute immediate`动态执行。但有一点尚未解决，就是在`execute immediate`后面的`select`语句不能跟上`;`，否则会报错`ORA-00933: SQL 命令未正确结束`，具体原因网上也无法查到
- 另外一点就是由于实验对新增表以及字段的阐述有很大的发展空间，在一开始我进行了一些假设，这才使得后面的实验不会混乱（尤其指字段间的冲突，更新的时机等等）
- 通过此次实验加深了对隐式游标，触发器以及存储过程的理解，提高了写代码能力

## 五、源程序

```plsql
-- 1. 1 创建映射表
create table t_status_score_map_D312 (
status varchar2(32) primary key,
score int
);

create synonym t_map for t_status_score_map_D312;
insert into t_map values('正常', 0);
insert into t_map values('请假', 1);
insert into t_map values('迟到', 2);
insert into t_map values('旷课', 5);

select * from t_map;


-- 1. 2 创建attend表
create table t_Attend_D312(
sno varchar2(32) references t_stud_D312(sno),
majorno varchar2(32) references t_major_D312(majorno),
class_date date,
period varchar2(32) check(period in ('12', '34', '56', '78', '90')),
status varchar2(32) check (status in ('正常', '请假', '迟到', '旷课')),
primary key(sno, class_date, period)
);

create synonym t_attend for t_Attend_D312;

-- 2. 为原先的两个表增加 sum_evaluation 字段
alter table t_stud_D312 add sum_evaluation int default 100;
alter table t_major_D312 add sum_evaluation int default 1000;

-- 3. 1 创建stud_attend表
create table t_stud_attend_D312 (
sno varchar2(32) references t_stud_D312(sno),
sname varchar2(32),
start_date date,
end_date date,
arrived int,
late int,
absenteeism int,
leave int,
score int,
primary key(sno, start_date, end_date)
);

-- 3. 2 创建major_attend表
create table t_major_attend_D312(
majorno references t_major_D312(majorno),
start_date date,
end_date date,
arrived int,
late int,
absenteeism int,
leave int,
loss_score int default 0,
primary key(majorno, start_date, end_date)
);

create synonym t_stud_attend for t_stud_attend_D312;
create synonym t_major_attend for t_major_attend_D312;

-- 4. 插入样本
set serveroutpu on;
declare
	sno1 t_stud_D312.majorno%type := '8208191312';
	sno2 t_stud_D312.majorno%type := '8224190337';
	sno3 t_stud_D312.majorno%type := '8224190340';

	majorno1 t_stud_D312.majorno%type;
	majorno2 t_stud_D312.majorno%type;	
	majorno3 t_stud_D312.majorno%type;

begin
	select majorno into majorno1 from t_stud_D312 where sno = sno1;
	select majorno into majorno2 from t_stud_D312 where sno = sno2;
	select majorno into majorno3 from t_stud_D312 where sno = sno3;

	insert into t_attend values(sno1, majorno1, to_date('2021-09-01','yyyy-mm-dd'), '12', '正常');
	insert into t_attend values(sno1, majorno1, to_date('2021-09-01','yyyy-mm-dd'), '34', '请假');
	insert into t_attend values(sno1, majorno1, to_date('2021-09-01','yyyy-mm-dd'), '56', '旷课');
	insert into t_attend values(sno1, majorno1, to_date('2021-09-01','yyyy-mm-dd'), '78', '迟到');
	insert into t_attend values(sno1, majorno1, to_date('2021-09-01','yyyy-mm-dd'), '90', '正常');

	insert into t_attend values(sno2, majorno2, to_date('2021-09-02','yyyy-mm-dd'), '12', '正常');
	insert into t_attend values(sno2, majorno2, to_date('2021-09-02','yyyy-mm-dd'), '34', '请假');
	insert into t_attend values(sno2, majorno2, to_date('2021-09-02','yyyy-mm-dd'), '56', '旷课');
	insert into t_attend values(sno2, majorno2, to_date('2021-09-02','yyyy-mm-dd'), '78', '迟到');

	insert into t_attend values(sno3, majorno3, to_date('2021-09-03','yyyy-mm-dd'), '12', '正常');
	insert into t_attend values(sno3, majorno3, to_date('2021-09-03','yyyy-mm-dd'), '34', '请假');
	insert into t_attend values(sno3, majorno3, to_date('2021-09-03','yyyy-mm-dd'), '56', '旷课');

end;	
/

set linesize 500;
select * from t_attend;

-- 5. 创建触发器
create or replace trigger tg_attend_D312
before insert or update or delete on t_attend
for each row

declare 
	old_score int;
	new_score int;
begin
	if inserting then
		select score into new_score from t_map where status=:new.status;
		update t_stud_D312 set sum_evaluation=sum_evaluation-new_score where t_stud_D312.sno = :new.sno;
		
	elsif deleting then
		select score into old_score from t_map where status=:old.status;
		update t_stud_D312 set sum_evaluation=sum_evaluation+old_score where t_stud_D312.sno = :old.sno;
		
	else 
		select score into new_score from t_map where status=:new.status;
		select score into old_score from t_map where status=:old.status;
		update t_stud_D312 set sum_evaluation=sum_evaluation-new_score+old_score where t_stud_D312.sno = :old.sno;
	end if;
	
end;
/

-- 插入操作验证
select sum_evaluation from t_stud_D312 where sno = '8224190333';
insert into t_attend values('8224190333', '24', to_date('2021-09-04','yyyy-mm-dd'), '12', '旷课');
select sum_evaluation from t_stud_D312 where sno = 8224190333;
-- 更新操作验证
update t_attend set status='请假' where sno='8224190333' and class_date=to_date('2021-09-04','yyyy-mm-dd') and period='12';
select sum_evaluation from t_stud_D312 where sno = '8224190333';
-- 删除操作验证
delete from t_attend where sno=8224190333 and class_date=to_date('2021-09-04','yyyy-mm-dd') and period='12';
select sum_evaluation from t_stud_D312 where sno = '8224190333';

-- 创建过程
-- 背景是现在已经做到：每次只操作t_attend表，通过上一步的触发器会自动更新t_stud表
-- 现在也要更新某一专业某一时间段的统计信息操作
-- 即
-- 通过遍历t_attend表中的有关字段
-- 得到正常，迟到，请假，旷课次数的统计
-- 从而更新汇总major表与major_attend表的统计信息字段

create or replace procedure p_major_attend_D312 
(
	majorno2 in varchar2,
	start_date in date,
	end_date in date
)
is
	arrived_num int := 0;
	late_num int := 0;
	absenteeism_num int := 0;
	leave_num int := 0;
	loss int := 0;  
begin
	-- 遍历t_attend表
	for cur in 
	(
		select t_attend.status tmp_status, t_map.score tmp_score from t_attend, t_map
		where t_attend.status=t_map.status 
			and t_attend.majorno = majorno2
			and t_attend.class_date >= start_date and t_attend.class_date <= end_date
	)
	loop
		-- 更新loss
		loss := loss + cur.tmp_score;

		-- 更新stud.attend 的次数相关字段
		if cur.tmp_status = '正常' then
			arrived_num := arrived_num + 1;
		elsif cur.tmp_status = '迟到' then
			late_num := late_num + 1;
		elsif cur.tmp_status = '旷课' then
			absenteeism_num := absenteeism_num + 1;
		else
			leave_num := leave_num + 1;
		end if;

	end loop;
	
	
	update t_major_attend set arrived = arrived_num , 
		late = late_num, absenteeism = absenteeism_num, 
		leave = leave_num, loss_score = loss 
		where t_major_attend.majorno = majorno2 
			and t_major_attend.start_date = start_date 
			and t_major_attend.end_date = end_date;

	-- 如果尚未存在该字段
	if sql%notfound then
		insert into t_major_attend values
		(majorno2, start_date, end_date, arrived_num, late_num, absenteeism_num, leave_num, loss);	
	end if;

	-- 更新major的统计信息
	update t_major_D312 set sum_evaluation = sum_evaluation - loss where t_major_D312.majorno = majorno2;
	
end;
/

-- 调用
exec p_major_attend_D312('08', to_date('2021-09-01', 'yyyy-mm-dd'), to_date('2022-01-22', 'yyyy-mm-dd'));
select * from t_major_attend;
select * from t_major_D312;

-- 检验更新操作
-- insert into t_attend values('8208191312', '08', to_date('2021-09-04','yyyy-mm-dd'), '90', '旷课');
-- exec p_major_attend_D312('08', to_date('2021-09-01', 'yyyy-mm-dd'), to_date('2022-01-22', 'yyyy-mm-dd'));
-- select * from t_major_attend;
-- select * from t_major_D312;
```


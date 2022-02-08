/*
student (学生信息表）
sno sname sex birthday class
108 曾华男09/01/77 95033
105 匡明男10/02/75 95031
107 王丽女01/23/76 95033
101 李军男02/20/76 95033
109 王芳女02/10/75 95031
103 陆军男06/03/74 95031
*/

create table student
(
sno char(10) primary key, --主码
sname char(10) not null,
sex char(2),
birthday datetime,
class char(10)
)

insert into student values('108','曾华','男','77/09/01','95033')
insert into student values('105','匡明','男','75/10/12','95031')
insert into student values('107','王丽','女','76/01/23','95033')
insert into student values('101','李军','男','77/02/20','95033')
insert into student values('109','王芳','女','75/02/10','95031')
insert into student values('103','陆军','男','74/06/03','95031')

select * from student

/*
teacher(老师信息表）
tno tname sex birthday prof depart
804 李诚男12/02/58 副教授计算机系
856 李旭男03/12/69 讲师电子工程系
825 王萍女05/05/72 助教计算机系
831 刘冰女08/14/77 助教电子工程系
*/

create table teacher
(
tno char(10) primary key, --主码
tname char(10) not null,
sex char(2),
birthday datetime,
prof char(15),
depart char(25)
)

insert into teacher values('804','李诚','男','58/12/02','副教授','计算机系')
insert into teacher values('856','李旭','男','69/03/12','讲师','电子工程系')
insert into teacher values('825','王萍','女','72/05/05','助教','计算机系')
insert into teacher values('831','刘冰','女','77/08/14','助教','电子工程系')

select * from teacher

/*
course(课程表）
cno cname tno
3-105 计算机导论825
3-245 操作系统804
6-166 数字电路856
9-888 高等数学825
*/

create table cource
(
cno char(15) primary key, --主码
cname char(15) not null,
tno char(10) not null
)

insert into cource values('3-105','计算机导论','825')
insert into cource values('3-245','操作系统','804')
insert into cource values('6-166','数字电路','856')
insert into cource values('9-888','高等数学','825')

select * from cource

/*
score(成绩表）
sno cno degree
103 3-245 86
105 3-245 75
109 3-245 68
103 3-105 92
105 3-105 88
109 3-105 76
101 3-105 64
107 3-105 91
108 3-105 78
101 6-166 85
107 6-166 79
108 6-166 81
*/

create table score
(
sno char(10) not null,
cno char(15) not null,
degree int
)

insert into score values('103','3-245','86')
insert into score values('105','3-245','75')
insert into score values('109','3-245','68')
insert into score values('103','3-105','92')
insert into score values('105','3-105','88')
insert into score values('109','3-105','76')
insert into score values('101','3-105','64')
insert into score values('107','3-105','91')
insert into score values('108','3-105','78')
insert into score values('101','6-166','85')
insert into score values('107','6-166','79')
insert into score values('108','6-166','81')

select * from score





select * from student
select * from cource
select * from score
select * from teacher



--1、列出student表中所有记录的sname、sex和class列。

select sname,sex,class from student

--2、显示教师所有的单位即不重复的depart列。

select distinct depart  from teacher

--3、显示学生表的所有记录。

select * from student

--4、显示score表中成绩在60到80之间的所有记录。

select * from score where degree between 60 and 80

select * from score where degree >=60 and degree <= 80

--5、显示score表中成绩为85，86或88的记录。

select * from score where degree in (85,86,88)

select * from score where degree =85 or degree =86 or degree =88

--6、显示student表中“95031”班或性别为“女”的同学记录。

select * from student where class ='95031' or sex='女'

--7、以class降序显示student表的所有记录。

select * from student order by class desc

--8、以cno升序、degree降序显示score表的所有记录。

select * from score order by cno asc,degree desc

--9、显示“95031”班的学生人数。

select * from student

select * from student where class='95031'

--10、显示score表中的最高分的学生学号和课程号。

select sno,cno from score where degree >= all(select degree from score)

select sno,cno from score where degree >= (select max(degree) from score)

select top 1 with ties sno,cno from score order by degree	--可能有相同分,使用with ties

--11、显示“3-105”号课程的平均分。

select * from score

select avg(degree) '3-105号课程平均分'
from score group by cno having cno='3-105'

select avg(degree) '3-105号课程平均分'
from score where cno='3-105' group by cno 

--12、显示score表中至少有5名学生选修的并以3开头的课程号的平均分数。

select * from score

select avg(degree) 平均分,count(*) 选课人数 from score where cno like '3%' group by cno having count(*)>=5

--13、显示最低分大于70，最高分小于90 的sno列。

select sno from score group by sno having min(degree) > 70 and max(degree) < 90

--14、显示所有学生的 sname、 cno和degree列。

select sname, cno, degree from student, score where student.sno=score.sno 

--15、显示所有学生的 sname、 cname和degree列。

select sname, cname, degree from student, score,cource where student.sno=score.sno and cource.cno=score.cno

--16、列出“95033”班所选课程的平均分。

select * from student

select avg(degree) from score 
	where sno in (select sno from student where class = '95033')

--17、显示选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。

select * from score

select * from student
	where sno in (
		select sno from score 
			where cno='3-105' and degree >( select degree from score where sno='109' and cno='3-105' )
	)

--18、显示score中选修多门课程的同学中分数为非最高分成绩的记录。

select a.sno, a.degree, a.cno from score a, score b
where a.sno=b.sno and a.degree<b.degree;

--19、显示成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。

select * from score where degree >(
	select degree from score where sno='109' and cno='3-105'
)

--20、显示出和学号为“108”的同学同年出生的所有学生的sno、sname和 birthday列。

select * from student


select sno, sname, birthday from student 
	where sno!='108' and year(birthday) = (select year(birthday) from student where sno='108')

--21、显示“李旭”老师任课的学生成绩。

select * from cource
select * from teacher
select * from score

select sno,degree from score where cno in(
	select cno from cource
		where tno = (select tno from teacher where tname='李旭')
)

--22、显示选修某课程的同学人数多于5人的老师姓名。

select tname from teacher where tno in(
	select tno from cource where cno in(
		select cno from score group by cno having count(sno)>5
	)
)

--23、显示“95033”班和“95031”班全体学生的记录。

select * from student where class in('95033','95031')

select * from student where class = '95033' or class = '95031'

--24、显示存在有85分以上成绩的课程cno。

select cno from score group by cno having max(degree)>=85

--25、显示“计算机系”老师所教课程的成绩表。

select * from score where cno in(
	select cno from cource where tno in(
		select tno from teacher where depart = '计算机系'
	)
)

select * from score,cource,teacher
	where score.cno=cource.cno and cource.tno= teacher.tno and teacher.depart = '计算机系'


--26、显示“计算机系”和“电子工程系”不同职称的老师的tname和prof。

select * from teacher

select tname , prof from teacher 
where depart='计算机系' and prof not in 
(select prof from teacher where depart='电子工程系')


--27、显示选修编号为“3-105”课程且成绩至少高于“3-245”课程的同学的cno、sno和degree，并按degree从高到低次序排列。

select cno, sno, degree from score where sno in(
	select sno from score where cno='3-105' and degree>(select min(degree) from score where cno='3-245')
) order by degree desc

--28、显示选修编号为“3-105”课程且成绩高于“3-245”课程的同学的cno、sno和degree。

select cno, sno, degree from score where sno in(
	select sno from score where cno='3-105' and degree>(select min(degree) from score where cno='3-245')
) 

--29、列出所有任课老师的tname和depart。

select tname,depart from teacher a
where exists(select * from cource b where a.tno=b.tno)

select tname,depart from teacher where tno in (select tno from cource)


--30、列出所有未讲课老师的tname和depart。

select tname,depart from teacher where tno not in (select tno from cource)

--31、列出所有老师和同学的 姓名、性别和生日。

select sname 姓名 ,sex 性别,birthday 生日 from student 
union
select tname 姓名,sex 性别,birthday 生日 from teacher

--*32、检索所学课程包含学生“103”所学课程的学生学号。

Select sno from score,(select cno from score where sno='103')course103
where score.cno=course103.cno 
group by sno having count(score.cno)=(select count(cno) from score where sno='103')



select * from student
select * from score

select  sno  from score x
where not exists
    (select * from score y
        where y.sno=103 and 
           not exists
             (select * from score z     
                 where z.sno=x.sno and z.cno=y.cno) ) 


--*33、检索选修所有课程的学生姓名。
select student.sname from student 
	where not exists (select *  from  cource 
		 where not exists 
			(select * from score 
			where student.sno=score.sno and cource.cno=score.cno))
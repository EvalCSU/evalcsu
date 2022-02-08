--【实验项目一】数据表, 索引, 视图创建, 修改,删除的设计与完整性约束

/*	借书证号 	姓名 	性别	出生日期 		借书量 	工作单位 	电话 		E-mail
	29307142	张晓露	女		1989-02-1		2		管理信息系	85860126	zxl@163.com
	36405216	李阳	男 		1988-12-26 		1		航海系		85860729	ly@sina.com.cn
	28308208	王新全	男 		1988-04-25 		1		人文艺术系 	85860618	wxq@yahoo.cn
	16406236	张继刚	男 		1989-08-18 		1		轮机工程系 	85860913	zjg@163.com
	16406247	顾一帆	男 		1981-12-30 		null		轮机工程系 	85860916	gyf@yahoo.cn	*/

drop table 读者信息表

create table 读者信息表(
读书证号 char(20) ,
姓名 char(20) not null,
性别 char(10),
出生日期 datetime,
借书量 int ,
工作单位 char(20),
电话 char(20),
Email char(30)
constraint a unique(电话),
constraint c primary key(读书证号),
constraint b check (借书量>0 and 借书量<60)
)

alter table 读者信息表 add constraint d unique(电话)
alter table 读者信息表 drop constraint b



select * from 读者信息表

sp_help 读者信息表

insert into 读者信息表 values('29307142','张晓露','女','1989-02-1',2,'管理信息系','85860126','zxl@163.com')
insert into 读者信息表 values('36405216','李阳','男','1988-12-26',1,'航海系','85860729','ly@sina.com.cn')
insert into 读者信息表 values('28308208','王新全','男','1988-04-25',1,'人文艺术系','85860618','wxq@yahoo.cn')
insert into 读者信息表 values('16406236','张继刚','男','1989-08-18',1,'轮机工程系','85860913','zjg@163.com')
insert into 读者信息表 values('16406247','顾一帆','男','1981-12-30',null,'轮机工程系','85860916','gyf@yahoo.cn')

---------------------------------------


drop table 工作人员

create table 工作人员(
工号 char(20) primary key,
姓名 char(10) not null,
性别 char(5),
出生日期  date,
联系电话  char(30) default'00000000',
Mail   char(30)
);
-----------------------------------


create table 图书类别(
类别号  char(20) primary key,
图书类别  char(20) not null
);

select * from 图书类别

insert into 图书类别 values ('H31','英语');
insert into 图书类别 values ('I267','当代作品');
insert into 图书类别 values ('TP312','程序语言');
insert into 图书类别 values ('TP393','计算机网络');
insert into 图书类别 values ('U66','船舶工程');

----------------------------------
create table 图书明细表(
类别号  char(20) references 图书类别(类别号),--两种外码创建方式
图书编号  char(20) primary key,
图书名称  char(30) not null,
作者   char(20),
出版社  char(30),
定价   int,
购进日期   date,
购入数   int,
复本数   int,
库存数   int
--foreign key(类别号) references 图书类别(类别号)
);

alter table 图书明细表
add constraint UQ_图书编号
unique (图书编号);

select * from 图书明细表
insert into 图书明细表 values ('I267','99011818','文化苦旅','余秋雨','知识出版社',16,'2000-03-19',8,15,14);
insert into 图书明细表 values ('TP312','00000476','Delphi高级开发指南','坎图','电子工业出版社',80,'2000-03-19',15,15,15);
insert into 图书明细表 values ('U66','01058589','船舶制造基础','杨敏','国防工业出版社',19,'2001-07-15',20,20,20);
insert into 图书明细表 values ('I267','07410139','艺海潮音','李叔','江苏文艺出版社',19,'2007-04-12',15,20,18);
insert into 图书明细表 values ('TP312','07410298','C++程序设计','成颖','东南大学出版社',38,'2007-05-08',10,15,14);
insert into 图书明细表 values ('H31','07410802','航海英语','陈宏权','武汉工业大学出版社',42,'2007-10-20',25,25,24);
insert into 图书明细表 values ('H31','07108667','大学英语学习辅导','姜丽蓉','北京理工大学出版社',23.5,'2008-02-06',25,25,25);
insert into 图书明细表 values ('TP393','07410810','网络工程实用教程','汪新民','北京大学出版社',34.8,'2008-08-21',10,15,15);
update 图书明细表 set 图书编号='00000746' where 图书名称='Delphi高级开发指南';

-----------------------------------------

create table 借还明细表(
读书证号 char(20) references 读者信息表(读书证号),
图书编号  char(20) references 图书明细表(图书编号),
借还 char(5) check (借还 in('借','还' ) ),
借书日期 datetime,
还书日期 datetime,
数量 int,
工号 char(20)
)

insert into 借还明细表 values ('29307142','07108667','还','2008-03-28','2008-04-14',1,'002016');
insert into 借还明细表 values ('29307142','99011818','借','2008-04-27',NULL,1,'002016');
insert into 借还明细表 values ('36405216','07410802','借','2008-04-27',NULL,1,'002018');
insert into 借还明细表 values ('29307142','07410298','借','2008-04-28','',1,'002018');
insert into 借还明细表 values ('36405216','00000746','还','2008-04-29','2008-05-09',1,'002016');
insert into 借还明细表 values ('28308208','07410139','借','2008-05-10','',1,'002019');
insert into 借还明细表 values ('16406236','07410139','借','2008-05-11','',1,'002017');

update 借还明细表 set 还书日期=NULL where 图书编号='07410298';
update 借还明细表 set 还书日期=NULL where 图书编号='07410802';
update 借还明细表 set 还书日期=null where 读书证号='16406236' and 图书编号='07410139';
update 借还明细表 set 还书日期=null where 读书证号='28308208' and 图书编号='07410139';

select * from 借还明细表

-----------------------------------


create table 图书借阅明细表(
图书编号  char(20) references 图书明细表(图书编号),
图书名称  char(30) not null,
读书证号 char(20) references 读者信息表(读书证号),
借出日期 datetime,
归还日期 datetime,
库存数 int not null,
);

insert into 图书借阅明细表 values('99011818','文化苦旅','29307142','2008-04-27','',14);
insert into 图书借阅明细表 values('07410802','航海英语','36405216','2008-04-27',NULL,24);
insert into 图书借阅明细表 values('07410298','C++程序设计语言','29307142','2008-04-28','',14);
insert into 图书借阅明细表 values('07410139','艺海潮音','28308208','2008-05-10','',18);
insert into 图书借阅明细表 values('07410139','艺海潮音','16406236','2008-05-11','',17);

select * from 图书借阅明细表
----------------------------

sp_helpconstraint 图书借阅明细表

create index a_idx on 图书借阅明细表(库存数)
alter index a_idx on 图书借阅明细表 rebuild
drop index a_idx on 图书借阅明细表

create view a_view  
as select * from 图书借阅明细表

select * from a_view
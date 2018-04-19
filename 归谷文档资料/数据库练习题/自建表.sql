1.用一条SQL语句 查询出每门课都大于80分的学生姓名  
name   kecheng   fenshu 
张三     语文       81
张三     数学       75
李四     语文       76
李四     数学       90
王五     语文       81
王五     数学       100
王五     英语       90

create table student1(
name varchar2(30),
kecheng varchar2(30),
fenshu number(3)
)

insert into student1 values('张三','语文',81);
insert into student1 values('张三','数学',75);
insert into student1 values('李四','语文',76);
insert into student1 values('李四','数学',90);
insert into student1 values('王五','语文',81);
insert into student1 values('王五','数学',100);
insert into student1 values('王五','英语',90);

select * from student1
select name from student1 group by name having min(fenshu)>80

自动编号   学号   姓名 课程编号 课程名称 分数
1        2005001  张三  0001      数学    69
2        2005002  李四  0001      数学    89
3        2005001  张三  0001      数学    69
删除除了自动编号不同,其他都相同的学生冗余信息


create sequence student2_seq 
minvalue 0
start with 1
increment by 1
maxvalue  9999999
nocache 
nocycle

create table student2(
自动编号 number(6) primary key,
学号 varchar2(20),
姓名 varchar2(30),
课程编号 varchar2(20),
课程名称 varchar2(20),
分数 number(3)
)

select student2_seq.nextval from dual;
insert into student2(自动编号,姓名,课程编号,课程名称,分数)
insert into student2 values(student2_seq.nextval,'2005001','张三','0001','数学',69);
insert into student2 values(student2_seq.nextval,'2005002','李四','0001','数学',89);
insert into student2 values(student2_seq.nextval,'2005001','张三','0001','数学',69);
select * from student2

delete student2 where 自动编号 
not in
(select min(自动编号) from student2  group by 学号, 姓名, 课程编号, 课程名称, 分数)



1991   1     1.1
1991   2     1.2
1991   3     1.3
1991   4     1.4
1992   1     2.1
1992   2     2.2
1992   3     2.3
1992   4     2.4
create table date1(
year varchar2(4),
month varchar2(2),
amount varchar2(6)
)

insert into date1 values('1991','1','1.1');
insert into date1 values('1991','2','1.2');
insert into date1 values('1991','3','1.3');
insert into date1 values('1991','4','1.4');
insert into date1 values('1992','1','2.1');
insert into date1 values('1992','2','2.2');
insert into date1 values('1992','3','2.3');
insert into date1 values('1992','4','2.4');

select * from date1
drop table date1
select year from date1 group by year

select y.year,m1,m2,m3,m4 from 
(select year from date1 group by year) y,
(select  year,amount as m1 from date1 where month=1) t1,
(select  year,amount as m2 from date1 where month=2) t2,
(select  year,amount  as m3 from date1 where month=3) t3,
(select  year,amount  as m4 from date1 where month=4) t4
where y.year=t1.year and t1.year=t2.year and t2.year=t3.year and t3.year=t4.year


courseid coursename score 
------------------------------------- 
1 java 70 
2 oracle 90 
3 xml 40 
4 jsp 30 
5 servlet 80 
------------------------------------- 
为了便于阅读,查询此表后的结果显式如下(及格分数为60): 
courseid coursename score mark 
--------------------------------------------------- 
1 java 70 pass 
2 oracle 90 pass 
3 xml 40 fail 
4 jsp 30 fail 
5 servlet 80 pass 

create table ss(
courseis varchar2(3),
coursename varchar2(20),
score number(3)
)
insert into ss values('1','java',70);
insert into ss values('2','oracle',90);
insert into ss values('3','xml',40);
insert into ss values('4','jsp',30);
insert into ss values('5','servlet',80);

select courseis, coursename,score,(case when score>60 then'pass' else 'fail' end) as mark from ss

2005-05-09 胜
2005-05-09 胜
2005-05-09 负
2005-05-09 负
2005-05-10 胜
2005-05-10 负
2005-05-10 负
create table game(
gamedate varchar2(30),
result varchar2(4)
)
insert into game values('2005-05-09','胜');
insert into game values('2005-05-09','胜');
insert into game values('2005-05-09','负');
insert into game values('2005-05-09','负');
insert into game values('2005-05-10','胜');
insert into game values('2005-05-10','负');
insert into game values('2005-05-10','负');
 
select gamedate,sum(case when result='胜' then 1 else 0 end) as 胜,
sum(case when result='负' then 1 else 0 end) as 负
from game
group by gamedate


create table select1(
a number(3),
b number(3),
c number(3)
)
insert into select1 values(2,5,4);
insert into select1 values(5,3,4);
insert into select1 values(3,6,9);
insert into select1 values(2,5,1);


select (case when a>b then a 
             when b>c then b 
             else c 
        end) as max
from select1


create table s(
sid varchar2(30),
sname varchar2(30)
)
insert into s values('1','aaa');
insert into s values('2','bbb');
insert into s values('3','ccc');
insert into s values('4','ddd');
insert into s values('5','eee');
insert into s values('6','fff');
insert into s values('7','ggg');

create table c(
cid varchar2(20),
cname varchar2(30),
teacher varchar2(30)
)
insert into c values('11','java','张三');
insert into c values('22','xml','李四');
insert into c values('33','oracle','王五');

create table sc(
sid varchar2(30),
cid varchar2(20),
scgrade number(3)
)
insert into sc values('1','11',66);
insert into sc values('1','22',45);
insert into sc values('1','33',88);

insert into sc values('2','11',58);
insert into sc values('2','22',44);
insert into sc values('2','33',67);

insert into sc values('3','11',69);
insert into sc values('3','22',90);
insert into sc values('3','33',56);

insert into sc values('4','11',85);
insert into sc values('4','22',77);
insert into sc values('4','33',62);

insert into sc values('5','11',62);
insert into sc values('5','22',77);
insert into sc values('5','33',88);

insert into sc values('6','11',35);
insert into sc values('6','22',65);
insert into sc values('6','33',50);

insert into sc values('7','11',90);
insert into sc values('7','22',90);
insert into sc values('7','33',90);

select * from s
select * from c
select * from sc

select s.sname,c.cname,c.teacher,sc.scgrade
from s,c,sc
where s.sid=sc.sid and c.cid=sc.cid


select teacher,sum(case when scgrade>60 then 0 else 1 end) as sum
from
(select c.teacher,sc.scgrade from c,sc where c.cid=sc.cid) t
group by teacher

select s.sname,c.cname,c.teacher,(case when scgrade>=90 then 'A'
                                       when scgrade>=70 and scgrade<90 then 'B'
                                       when scgrade>=60 and scgrade<70 then 'C'
                                       else 'D'
                                   end
                                  )
from s,c,sc
where s.sid=sc.sid and c.cid=sc.cid

select teacher,sum(case when lev='A' then 1 else 0 end) from
(select c.teacher,(case when scgrade>=90 then 'A'
                                       when scgrade>=70 and scgrade<90 then 'B'
                                       when scgrade>=60 and scgrade<70 then 'C'
                                       else 'D'
                                   end
                                  )as lev
from c,sc
where c.cid=sc.cid) t
group by teacher






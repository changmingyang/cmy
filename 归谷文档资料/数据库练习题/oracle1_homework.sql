select *
from employees

select last_name
from employees

select e.first_name,e.last_name,to_char(e.salary,'L99,999,999.99') as sal
from employees e

select sysdate from dual

select * from employees

select  max(salary)
from employees


--组函数 min max avg count sum
select min(salary) from employees
--返回组中总记录数
select count(*) from employees
--查找这一列非空数目的总和
select count(commission_pct) from employees
select avg(salary) from employees
select sum(salary) from employees
--组函数可以忽略空值
select avg(commission_pct) from employees
--组函数无法忽略nvl
select avg(nvl(commission_pct,0)) from employees


--分组函数
select e.department_id,min(salary),max(salary),avg(salary),sum(salary)
from employees e
group by e.department_id
order by e.department_id

--group by 后面可以跟多个分组条件
select e.department_id,job_id,min(e.salary)
from employees e
group by e.department_id,e.job_id  --先根据departmrnt_id分组，再根据job_id分组
order by e.department_id

--select语句中没有出现在组函数中的列一定要包含在group by中

--组函数不能出现在where子句中
--如where avg(salary)>4000  就会报错

--解决方法
select e.department_id,max(salary),min(salary),avg(salary)
from employees e
group by e.department_id
having max(salary)>12000-------
order by e.department_id

--组函数嵌套
--组函数最多嵌套两个
select min(max(e.salary))
from employees e
group by e.department_id
order by e.department_id



--集合运算
select e.employee_id,e.job_id from employees e  --107
union  --all  返回的是全部的                           --115并集，去掉重复的行
select d.employee_id,d.job_id from job_history d  --10

select e.employee_id,e.job_id from employees e  --107
intersect                                                       --2交集取相等的行
select d.employee_id,d.job_id from job_history d  --10

select e.employee_id,e.job_id from employees e  --107
minus                                                    --105差集第一个中没有，第二个中有的
select d.employee_id,d.job_id from job_history d  --10


--多表查询
--笛卡儿积  没有连接条件，第一个表中的每一行与另一个表中的每一行相连接
select  e.employee_id, e.first_name,d.department_name
from employees e,departments d

--等值连接  返回的是笛卡儿积中满足条件的行
select  e.employee_id, e.first_name,d.department_name
from employees e,departments d
where e.department_id=d.department_id
--不等值连接

--外连接   分为左外连接和右外连接
select  e.employee_id, e.first_name,d.department_name
from employees e,departments d
where e.department_id=d.department_id(+)

--自然连接   自己和自己连接

select * from employees
select e.employee_id,e.first_name,ee.first_name
from employees e,employees ee
where e.manager_id=ee.employee_id
order by e.employee_id


select * from employees


--哪些部门的人数比90号部门的人数多
select department_id,count(*)
from employees
group by department_id
having count(*)> (select count(*) from employees where department_id=90)
order by department_id

--Den(first_name)\Raphaely(last_name)的领导是谁（非关联子查询）

select first_name,last_name,manager_id
from employees
where employee_id=(select manager_id from employees where first_name ='Den' and last_name='Raphaely')

--Den(first_name)\Raphaely(last_name)领导谁（非关联子查询）
select employee_id,first_name,last_name,manager_id
from employees
where manager_id=(select employee_id from employees where first_name ='Den' and last_name='Raphaely')


--Den(first_name)\Raphaely(last_name)的领导是谁（关联子查询）
select first_name,last_name,manager_id
from employees e
where exists(select * from employees ee where first_name='Den' and last_name='Raphaely' and e.employee_id=ee.manager_id)

--Den(first_name)\Raphaely(last_name)领导谁（关联子查询）
select employee_id,first_name,last_name,manager_id
from employees e
where exists(select * from employees ee where first_name ='Den' and last_name='Raphaely' and e.manager_id=ee.employee_id)

--列出在同一个部门共事，入职日期晚，但工资高于其他同事的员工的：名字、工资、入职日期(关联子查询)
select first_name||' '||last_name,salary,hire_date

select department_id, min(hire_date)
from employees
group by department_id
order by department_id

select * from employees 


select first_name||' '||last_name,salary,hire_date,department_id
from employees e
where exists(select * from employees ee
             where ee.department_id=e.department_id
             and e.hire_date>ee.hire_date
             and e.salary>ee.salary
             )
--哪些员工跟Den(first_name)\Raphaely(last_name)不再同一个部门（非关联子查询）
select employee_id,first_name,last_name,department_id
from employees
where department_id<>(select department_id from employees where first_name ='Den' and last_name='Raphaely')
--哪些员工跟Den(first_name)\Raphaely(last_name)不再同一个部门（关联子查询）
select employee_id,first_name,last_name,department_id
from employees e
where exists(select * from employees ee where ee.first_name ='Den' and ee.last_name='Raphaely' and ee.department_id<>e.department_id)
--finance部门有哪些职位（非关联子查询）
select distinct job_id from employees
where department_id=(select department_id from departments where lower(department_name)='finance')
--finance部门有哪些职位（关联子查询）
select distinct job_id from employees e
where exists(select * from departments d where lower(department_name)='finance' and d.department_id=e.department_id)



--让SELECT TO_CHAR(SALARY,'L99,999.99') FROM HR.EMPLOYEES WHERE  ROWNUM < 5 输出结果的货币单位是￥和$。
select * from employees

select first_name,TO_CHAR(SALARY,'L99,999.99') 
from employees
where rownum<5

--列出前五位每个员工的名字，工资、涨薪后的的工资（涨幅为8%），以“元”为单位进行四舍五入。
select first_name,salary,round(salary*(1+0.08)) as new_salary 
from employees
where rownum<=5

--找出谁是最高领导，将名字按大写形式显示。
select upper(first_name||' '||last_name)
from employees
where manager_id is null

--找出First_Name 为David，Last_Name为Austin 的直接领导名字。

select first_name||' '||last_name
from employees
where employee_id=(select manager_id from employees where first_name='David' and last_name='Austin')

--First_Name 为Alexander，Last_Name为Hunold领导谁。（谁向David 报告）
select employee_id,first_name,salary,manager_id
from employees
where manager_id=(select employee_id
from employees
where first_name='Alexander' and last_name='Hunold')

--哪些员工的工资高于他直接上司的工资，列出员工的名字和工资，上司的名字和工资。
select e.first_name,ee.first_name,e.salary
from employees e ,employees ee
where e.manager_id=ee.employee_id and e.salary>ee.salary


--哪些员工和Chen(LAST_NAME)同部门。
select first_name,department_id
from employees
where department_id=(select department_id
from employees
where last_name='Hall')
--哪些员工跟De Haan(LAST_NAME)做一样职位。
select first_name,job_id
from employees
where job_id=(select job_id
from employees
where first_name='William'and last_name='Smith')
--哪些员工跟Hall(LAST_NAME)不在同一个部门
select first_name,department_id
from employees
where department_id<>(select department_id
from employees
where last_name='Hall')

--哪些员工跟William（FIRST_NAME）、Smith(LAST_NAME)做不一样的职位。
select first_name,job_id
from employees
where job_id<>(select job_id
from employees
where first_name='William'and last_name='Smith')

--显示有提成的员工的信息：名字、提成、所在部门名称、所在地区的名称。
select * from locations
select * from departments
select * from employees
select e.first_name,e.commission_pct,e.department_id,d.department_name,l.city
from employees e,departments d,locations l
where e.commission_pct is not null and e.department_id=d.department_id and d.location_id=l.location_id


--显示Executive部门有哪些职位。
select distinct job_id from employees e
where e.department_id=(select d.department_id from departments d where d.department_name='Executive')

select distinct job_id from employees e
where exists(select * from departments d where d.department_name='Executive' and d.department_id=e.department_id)

--整个公司中，最高工资和最低工资相差多少。
select max(salary),min(salary)
from employees
select (max(salary)-min(salary)) as mul
from employees

--提成大于0 的人数。
select count(commission_pct)
from employees

--显示整个公司的最高工资、最低工资、工资总和、平均工资保留到整数位。
select max(salary),min(salary),sum(salary),trunc(avg(salary))
from employees

--整个公司有多少个领导。
select count(*) from
(select nvl(manager_id,0) as mi
from employees
group by manager_id) emp

--列出在同一部门入职日期晚但工资高于其他同事的员工：名字、工资、入职日期。
select first_name,salary,hire_date
from employees e
where exists(select * from employees ee where ee.department_id=e.department_id and ee.salary<e.salary and ee.hire_date<e.hire_date)

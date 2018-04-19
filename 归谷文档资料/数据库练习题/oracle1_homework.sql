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


--�麯�� min max avg count sum
select min(salary) from employees
--���������ܼ�¼��
select count(*) from employees
--������һ�зǿ���Ŀ���ܺ�
select count(commission_pct) from employees
select avg(salary) from employees
select sum(salary) from employees
--�麯�����Ժ��Կ�ֵ
select avg(commission_pct) from employees
--�麯���޷�����nvl
select avg(nvl(commission_pct,0)) from employees


--���麯��
select e.department_id,min(salary),max(salary),avg(salary),sum(salary)
from employees e
group by e.department_id
order by e.department_id

--group by ������Ը������������
select e.department_id,job_id,min(e.salary)
from employees e
group by e.department_id,e.job_id  --�ȸ���departmrnt_id���飬�ٸ���job_id����
order by e.department_id

--select�����û�г������麯���е���һ��Ҫ������group by��

--�麯�����ܳ�����where�Ӿ���
--��where avg(salary)>4000  �ͻᱨ��

--�������
select e.department_id,max(salary),min(salary),avg(salary)
from employees e
group by e.department_id
having max(salary)>12000-------
order by e.department_id

--�麯��Ƕ��
--�麯�����Ƕ������
select min(max(e.salary))
from employees e
group by e.department_id
order by e.department_id



--��������
select e.employee_id,e.job_id from employees e  --107
union  --all  ���ص���ȫ����                           --115������ȥ���ظ�����
select d.employee_id,d.job_id from job_history d  --10

select e.employee_id,e.job_id from employees e  --107
intersect                                                       --2����ȡ��ȵ���
select d.employee_id,d.job_id from job_history d  --10

select e.employee_id,e.job_id from employees e  --107
minus                                                    --105���һ����û�У��ڶ������е�
select d.employee_id,d.job_id from job_history d  --10


--����ѯ
--�ѿ�����  û��������������һ�����е�ÿһ������һ�����е�ÿһ��������
select  e.employee_id, e.first_name,d.department_name
from employees e,departments d

--��ֵ����  ���ص��ǵѿ�������������������
select  e.employee_id, e.first_name,d.department_name
from employees e,departments d
where e.department_id=d.department_id
--����ֵ����

--������   ��Ϊ�������Ӻ���������
select  e.employee_id, e.first_name,d.department_name
from employees e,departments d
where e.department_id=d.department_id(+)

--��Ȼ����   �Լ����Լ�����

select * from employees
select e.employee_id,e.first_name,ee.first_name
from employees e,employees ee
where e.manager_id=ee.employee_id
order by e.employee_id


select * from employees


--��Щ���ŵ�������90�Ų��ŵ�������
select department_id,count(*)
from employees
group by department_id
having count(*)> (select count(*) from employees where department_id=90)
order by department_id

--Den(first_name)\Raphaely(last_name)���쵼��˭���ǹ����Ӳ�ѯ��

select first_name,last_name,manager_id
from employees
where employee_id=(select manager_id from employees where first_name ='Den' and last_name='Raphaely')

--Den(first_name)\Raphaely(last_name)�쵼˭���ǹ����Ӳ�ѯ��
select employee_id,first_name,last_name,manager_id
from employees
where manager_id=(select employee_id from employees where first_name ='Den' and last_name='Raphaely')


--Den(first_name)\Raphaely(last_name)���쵼��˭�������Ӳ�ѯ��
select first_name,last_name,manager_id
from employees e
where exists(select * from employees ee where first_name='Den' and last_name='Raphaely' and e.employee_id=ee.manager_id)

--Den(first_name)\Raphaely(last_name)�쵼˭�������Ӳ�ѯ��
select employee_id,first_name,last_name,manager_id
from employees e
where exists(select * from employees ee where first_name ='Den' and last_name='Raphaely' and e.manager_id=ee.employee_id)

--�г���ͬһ�����Ź��£���ְ�����������ʸ�������ͬ�µ�Ա���ģ����֡����ʡ���ְ����(�����Ӳ�ѯ)
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
--��ЩԱ����Den(first_name)\Raphaely(last_name)����ͬһ�����ţ��ǹ����Ӳ�ѯ��
select employee_id,first_name,last_name,department_id
from employees
where department_id<>(select department_id from employees where first_name ='Den' and last_name='Raphaely')
--��ЩԱ����Den(first_name)\Raphaely(last_name)����ͬһ�����ţ������Ӳ�ѯ��
select employee_id,first_name,last_name,department_id
from employees e
where exists(select * from employees ee where ee.first_name ='Den' and ee.last_name='Raphaely' and ee.department_id<>e.department_id)
--finance��������Щְλ���ǹ����Ӳ�ѯ��
select distinct job_id from employees
where department_id=(select department_id from departments where lower(department_name)='finance')
--finance��������Щְλ�������Ӳ�ѯ��
select distinct job_id from employees e
where exists(select * from departments d where lower(department_name)='finance' and d.department_id=e.department_id)



--��SELECT TO_CHAR(SALARY,'L99,999.99') FROM HR.EMPLOYEES WHERE  ROWNUM < 5 �������Ļ��ҵ�λ�ǣ���$��
select * from employees

select first_name,TO_CHAR(SALARY,'L99,999.99') 
from employees
where rownum<5

--�г�ǰ��λÿ��Ա�������֣����ʡ���н��ĵĹ��ʣ��Ƿ�Ϊ8%�����ԡ�Ԫ��Ϊ��λ�����������롣
select first_name,salary,round(salary*(1+0.08)) as new_salary 
from employees
where rownum<=5

--�ҳ�˭������쵼�������ְ���д��ʽ��ʾ��
select upper(first_name||' '||last_name)
from employees
where manager_id is null

--�ҳ�First_Name ΪDavid��Last_NameΪAustin ��ֱ���쵼���֡�

select first_name||' '||last_name
from employees
where employee_id=(select manager_id from employees where first_name='David' and last_name='Austin')

--First_Name ΪAlexander��Last_NameΪHunold�쵼˭����˭��David ���棩
select employee_id,first_name,salary,manager_id
from employees
where manager_id=(select employee_id
from employees
where first_name='Alexander' and last_name='Hunold')

--��ЩԱ���Ĺ��ʸ�����ֱ����˾�Ĺ��ʣ��г�Ա�������ֺ͹��ʣ���˾�����ֺ͹��ʡ�
select e.first_name,ee.first_name,e.salary
from employees e ,employees ee
where e.manager_id=ee.employee_id and e.salary>ee.salary


--��ЩԱ����Chen(LAST_NAME)ͬ���š�
select first_name,department_id
from employees
where department_id=(select department_id
from employees
where last_name='Hall')
--��ЩԱ����De Haan(LAST_NAME)��һ��ְλ��
select first_name,job_id
from employees
where job_id=(select job_id
from employees
where first_name='William'and last_name='Smith')
--��ЩԱ����Hall(LAST_NAME)����ͬһ������
select first_name,department_id
from employees
where department_id<>(select department_id
from employees
where last_name='Hall')

--��ЩԱ����William��FIRST_NAME����Smith(LAST_NAME)����һ����ְλ��
select first_name,job_id
from employees
where job_id<>(select job_id
from employees
where first_name='William'and last_name='Smith')

--��ʾ����ɵ�Ա������Ϣ�����֡���ɡ����ڲ������ơ����ڵ��������ơ�
select * from locations
select * from departments
select * from employees
select e.first_name,e.commission_pct,e.department_id,d.department_name,l.city
from employees e,departments d,locations l
where e.commission_pct is not null and e.department_id=d.department_id and d.location_id=l.location_id


--��ʾExecutive��������Щְλ��
select distinct job_id from employees e
where e.department_id=(select d.department_id from departments d where d.department_name='Executive')

select distinct job_id from employees e
where exists(select * from departments d where d.department_name='Executive' and d.department_id=e.department_id)

--������˾�У���߹��ʺ���͹��������١�
select max(salary),min(salary)
from employees
select (max(salary)-min(salary)) as mul
from employees

--��ɴ���0 ��������
select count(commission_pct)
from employees

--��ʾ������˾����߹��ʡ���͹��ʡ������ܺ͡�ƽ�����ʱ���������λ��
select max(salary),min(salary),sum(salary),trunc(avg(salary))
from employees

--������˾�ж��ٸ��쵼��
select count(*) from
(select nvl(manager_id,0) as mi
from employees
group by manager_id) emp

--�г���ͬһ������ְ���������ʸ�������ͬ�µ�Ա�������֡����ʡ���ְ���ڡ�
select first_name,salary,hire_date
from employees e
where exists(select * from employees ee where ee.department_id=e.department_id and ee.salary<e.salary and ee.hire_date<e.hire_date)

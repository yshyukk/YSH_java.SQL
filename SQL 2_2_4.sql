--�ӽ����̺� : �� ���� ���̺�

--Creating a Temporary Table
	-- on commit delete rows	: commit �� ������ ����
	--on commit preserve rows  : session ���� �ÿ� ������ ����
create global temporary table emp_temp1
on commit delete rows
as
select employee_id, last_name,salary from employees;

create global temporary table emp_temp2
on commit preserve rows
as
select employee_id, last_name, salary from employees;

--SQL Developer ���� �� �����

--Using a Temporary Table

select * from emp_temp1;

select * from emp_temp2;

insert into emp_temp1
select employee_id, last_name, salary
from employees
where department_id = 50;

insert into emp_temp2
select employee_id, last_name, salary
from employees
where department_id in (80,90);

select * from emp_temp1;

select * from emp_temp2;

commit;

select * from emp_temp1;

select * from emp_temp2;

--SQL Developer �߰� ���� �� �λ������ ���� 
select * from emp_temp2;

insert into emp_temp2
select employee_id, last_name, salary
from employees
where department_id=60;

commit;

select * from emp_temp2;

--�� ��° SQL Developer ����
--Clear Test

drop table emp_temp1;

drop table emp_temp2;


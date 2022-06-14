--임시테이블 : 내 전용 테이블

--Creating a Temporary Table
	-- on commit delete rows	: commit 후 데이터 삭제
	--on commit preserve rows  : session 종료 시에 데이터 삭제
create global temporary table emp_temp1
on commit delete rows
as
select employee_id, last_name,salary from employees;

create global temporary table emp_temp2
on commit preserve rows
as
select employee_id, last_name, salary from employees;

--SQL Developer 종료 후 재실행

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

--SQL Developer 추가 실행 후 인사관리로 접속 
select * from emp_temp2;

insert into emp_temp2
select employee_id, last_name, salary
from employees
where department_id=60;

commit;

select * from emp_temp2;

--두 번째 SQL Developer 종료
--Clear Test

drop table emp_temp1;

drop table emp_temp2;


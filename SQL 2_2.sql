--Create a Table For Test
drop table dept80 purge;

create table dept80
as
select employee_id, last_name, salary*12 as annsal, hire_date
from employees
where department_id = 80;

desc dept80

select * from dept80;

--Adding a Column
alter table dept80
add email varchar2(30);

--Adding a Column with DEFAULT value
alter table dept80
add job varchar2(10) DEFAULT 'Not Yet';

desc dept80

select * from dept80;

--modifying a Column
alter table dept80
modify last_name varchar2(30);

desc dept80;

ALTER TABLE dept80
MODIFY email DEFAULT 'None';

SELECT * FROM dept80;

UPDATE dept80
SET email=default;

SELECT * FROM dept80;

COMMIT;
--Dropping a Column
alter table dept80
drop column hire_date;

select * from dept80;

desc dept80;

-- unused는 실행하면 자동 commit! 되돌릴수 없음. 삭제밖에는..
alter table dept80
set unused column annsal;

alter table dept80
set unused column email;

desc dept80

select * from dept80;

alter table dept80

drop unused columns;
--Clear Test
drop table dept80 purge;
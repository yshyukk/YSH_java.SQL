--Create Index with the Create Table statement
    --PURGE : ������ ���� ����
DROP TABLE emp2 PURGE;

create table emp2
(empid number(6) primary key,
empname varchar2(30),
salary number(6),
department_id number(3));

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2';

ALTER TABLE emp2 DISABLE primary key;
--disable �ϸ� index�� �ڵ����� �����
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2';

ALTER TABLE emp2 ENABLE primary key;

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2';

drop table emp2 purge;

--using index�� : index�����ϴ� ���
create table emp2
(empid number(6) primary key using index
            (create index emp2_empid_idx on emp2(empid)),
empname varchar2(30),
salary number(6),
department_id number(3));

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2';

ALTER TABLE emp2 DISABLE primary key;

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

--enable�ص� index ����.
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2';

ALTER TABLE emp2 ENABLE primary key;

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2';

--Function Based Indexes

create index emp_sal_ix on employees(salary);

alter index emp_sal_ix monitoring usage;

select * from employees
where salary*12 > 80000;
--���� index ����ϴ��� ���� Ȯ��
select * from v$object_usage;

drop index emp_sal_ix;
--�Լ���� index
    --�÷��ڸ��� ����
create index emp_annsal_ix on employees(salary*12);

alter index emp_annsal_ix monitoring usage;

select * from employees
where salary*12 > 80000;

select * from v$object_usage;

--Clear Test
drop index emp_annsal_ix;

--Drop Table with Recyclebin
show recyclebin;

PURGE recyclebin;

show recyclebin;

drop table emp2;

desc emp2
select * from emp2;

show recyclebin;

-- drop table�� flashback(����)����.
flashback table emp2 to before drop;

desc emp2
select * from emp2;

show recyclebin;

drop table emp2 purge;

show recyclebin;

flashback table emp2 to before drop;

show recyclebin;
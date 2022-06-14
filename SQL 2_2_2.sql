--Create a Table For Test
drop table emp2 purge;

create table emp2
as
select * from employees;

select table_name, constraint_name, constraint_type, status, search_condition
from user_constraints
where table_name = 'EMP2';

--Adding a Constraints
alter table emp2
add primary key(employee_id);

alter table emp2
add constraint emp2_email_uk unique (email);

select table_name, constraint_name, constraint_type, status,search_condition
from user_constraints
where table_name = 'EMP2';

--Disable a Constraints(PRIMARY KEY)
alter table emp2
disable primary key;

--�������ǿ� �����ϵ��� ������ ����(PRIMARY KEY ���� �ߺ������ͻ���)
update emp2
set employee_id = 102
where employee_id = 101;
commit;

SELECT employee_id
FROM emp2
WHERE employee_id = 102;
--Disable a Constraints(Non Primary Key)

alter table emp2
disable constraint emp2_email_uk;

--�������� ����Ȯ��
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

--Enabling a Constraints
alter table emp2
enable constraint emp2_email_uk;

--�߸��� �����ͷ� ���� �������� Ȱ��ȭ�� ������ ��� �ذ���(Exceptionó��)
alter table emp2
enable primary key; 

create table exceptions(row_id rowid,
	                owner varchar2(128),
	                table_name varchar2(128),
		        constraint varchar2(128));
                
alter table emp2
enable primary key
exceptions into exceptions;

SELECT * FROM exceptions;

SELECT *
FROM emp2;


SELECT employee_id, rowid
FROM emp2
WHERE rowid In (SELECT row_id FROM exceptions);
--rowid �� ���� 

UPDATE emp2
SET employee_id = 101
WHERE rowid='AAAE9ZAAEAAAALbAAB';

--������ rowid �� ���
SELECT *
FROM emp2
WHERE employee_id IN (101,102);

COMMIT;

ALTER TABLE emp2
ENABLE primary key;

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

TRUNCATE TABLE exceptions;

--���ýǽ�
--�����Ͱ� ���� ���̺��� �������� ��Ȱ��ȭ ���� ������ �������� ���� ������ �ĺ��ϰ� �ذ��ϴ� ���(EXCEPTION ó��)
--Dropping a Constraints
alter table emp2 
drop primary key;

alter table emp2
drop constraint emp2_email_uk;

select table_name, constraint_name, constraint_type, status, search_condition
from user_constraints
where table_name = 'EMP2';

========================�߰�
--SELECT 'ALTER TABLE emp2 DROP CONSTRAINT' ||constraint_name ||'
--FROM user_constraints
--WHERE table_name = 'EMP2';

--ALTER TABLE emp2 DROP CONSTRAINT SYS_007151;
--ALTER TABLE emp2 DROP CONSTRAINT SYS_007152;
--ALTER TABLE emp2 DROP CONSTRAINT SYS_007153;
--ALTER TABLE emp2 DROP CONSTRAINT SYS_007154;

--Cascading Constraints
--Column Drop �� �߰� �ɼ�
CREATE TABLE test1(
a NUMBER PRIMARY KEY,
b NUMBER,
c NUMBER,
d NUMBER,
CONSTRAINT test1_b_fk FOREIGN KEY (b) REFERENCES test1,
CONSTRAINT ck1 CHECK (a > 0 and c > 0),
CONSTRAINT ck2 CHECK (d > 0));

desc test1

select table_name, constraint_name, constraint_type, status, search_condition
from user_constraints
where table_name = 'TEST1';

alter table test1
drop column d;

DESC test1

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'TEST1';

alter table test1
drop column c;

alter table test1
drop column a;

-- cascade constraints : 
alter table test1
drop column a cascade constraints;

desc test1

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'TEST1';

alter table test1 

drop column c;

desc test1
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'TEST1';

DESC test1

--Renaming Table Columns and Contraints

DESC emp2

alter table emp2
rename column employee_id to empid;

desc emp2

alter table emp2
add constraint emp2_pk primary key(empid);

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

alter table emp2
rename constraint emp2_pk to emp2_empid_pk;

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

--Clean Test
drop table emp2 purge;
drop table test1 purge;
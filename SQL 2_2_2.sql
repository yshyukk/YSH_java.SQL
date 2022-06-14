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

--제약조건에 위반하도록 데이터 수정(PRIMARY KEY 열에 중복데이터생성)
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

--제약조건 상태확인
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

--Enabling a Constraints
alter table emp2
enable constraint emp2_email_uk;

--잘못된 데이터로 인해 제약조건 활성화에 실패한 경우 해결방법(Exception처리)
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
--rowid 값 복사 

UPDATE emp2
SET employee_id = 101
WHERE rowid='AAAE9ZAAEAAAALbAAB';

--복사한 rowid 값 사용
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

--선택실습
--데이터가 많은 테이블에서 제약조건 비활성화 동안 수정된 제약조건 위반 데이터 식별하고 해결하는 방법(EXCEPTION 처리)
--Dropping a Constraints
alter table emp2 
drop primary key;

alter table emp2
drop constraint emp2_email_uk;

select table_name, constraint_name, constraint_type, status, search_condition
from user_constraints
where table_name = 'EMP2';

========================추가
--SELECT 'ALTER TABLE emp2 DROP CONSTRAINT' ||constraint_name ||'
--FROM user_constraints
--WHERE table_name = 'EMP2';

--ALTER TABLE emp2 DROP CONSTRAINT SYS_007151;
--ALTER TABLE emp2 DROP CONSTRAINT SYS_007152;
--ALTER TABLE emp2 DROP CONSTRAINT SYS_007153;
--ALTER TABLE emp2 DROP CONSTRAINT SYS_007154;

--Cascading Constraints
--Column Drop 시 추가 옵션
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
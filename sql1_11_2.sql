--시퀀스의 생성
CREATE SEQUENCE dept_deptid_seq
                INCREMENT BY 10
                START WITH 250
                MAXVALUE 9999
                NOCACHE
                NOCYCLE;
SELECT sequence_name, increment_by, cache_size, last_number
FROM user_sequences
WHERE sequence_name LIKE 'DEPT%';
INSERT INTO departments(department_id, department_name, location_id)
VALUES      (dept_deptid_seq.NEXTVAL, 'Support', 2500);
SELECT * FROM departments;
rollback;
INSERT INTO departments(department_id, department_name, location_id)
VALUES      (dept_deptid_seq.NEXTVAL, 'Support', 2500);
SELECT * FROM departments;
COMMIT;
--시퀀스 수정
ALTER SEQUENCE dept_deptid_seq
               INCREMENT BY 20
               MAXVALUE 999999
               NOCACHE
               NOCYCLE;
SELECT sequence_name, increment_by, cache_size, last_number
FROM user_sequences
WHERE sequence_name LIKE 'DEPT%';               
DROP SEQUENCE dept_deptid_seq;
--자동 인덱스 생성
DROP TABLE emp;
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4));
--제약조건 관련 딕셔너리 정보 보기
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';
--수동으로 인덱스 생성
CREATE INDEX emp_ename_idx ON emp(ename);
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';
--인덱스 삭제
DROP INDEX emp_email_uk;
DROP INDEX emp_ename_idx;
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';
--동의어 생성
SELECT * FROM dept_sum_vu;
CREATE SYNONYM d_sum FOR dept_sum_vu;
SELECT * FROM d_sum;
--동의어 관련 데이터딕셔너리 보기
SELECT synonym_name, table_owner, table_name
FROM user_synonyms;
--동의어 삭제
DROP SYNONYM d_sum;
DROP TABLE emp;
--테이블 삭제 시 기타 객체들에 대한 정보 확인하기
CREATE TABLE test
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4));
CREATE INDEX test_job_ix 
ON test(job);
CREATE SEQUENCE test_no_seq
INCREMENT BY 1
START WITH 301
NOCACHE
NOCYCLE;
CREATE VIEW test_sum_vu
AS
SELECT empno, ename, job, deptno
FROM test;
CREATE SYNONYM t
FOR test_sum_vu;
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'TEST';
SELECT object_name,object_type, status FROM user_objects
WHERE object_name LIKE 'TEST%' OR object_name ='T';
DROP TABLE test;
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'TEST';
SELECT object_name,object_type, status FROM user_objects
WHERE object_name LIKE 'TEST%' OR object_name ='T';
DROP sequence test_no_seq;
DROP VIEW test_sum_vu;
DROP SYNONYM t;
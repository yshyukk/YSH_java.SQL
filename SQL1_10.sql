--테이블 생성과 삭제
CREATE TABLE dept (deptno   NUMBER(2),
         dname       VARCHAR2(14),
         loc         VARCHAR2(13));

DESC dept;

--기본값 테스트
    --기본키가 없을때는 계속 추가됨.
INSERT INTO dept(deptno, dname)
VALUES(10, '기획부');

INSERT INTO dept
VALUES(20, '영업부', '서울');

COMMIT;

SELECT * FROM dept;

ROLLBACK;

DESC employees;

--rowid : 행의 고유한 정보를 찾아줌. (18자리)
SELECT employee_id, rowid
FROM employees;

-- 해당 사원 id의 rowid 를 조회하면 해당 사원의 정보가 나옴.
SELECT *
FROM employees
WHERE rowid = 'AAAE5oAAEAAAADMAAA';

-- 값은 같아도 rowid는 다름.

SELECT deptno, dname, rowid
FROM dept;

DROP TABLE dept PURGE;

--기본키와 기본값 열을 포함하는 테이블 생성
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY,
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE);

DROP TABLE dept;

CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY,
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE);
--기본값 테스트
INSERT INTO dpt(deptno, dname)
VALUES(10, '기획부');

INSERT INTO dept
VALUES(20, '영업부', '서울', '19/03/14');

COMMIT;

SELECT * FROM dept;

--여러가지 제약조건을 포함하는 테이블 생성
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4)REFERENCES dept(deptno));

--제약조건 관련 딕셔너리 정보 보기 (user_원하는 정보)
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';

-- 딕셔너리에서 조건을 주는 where절에는 대문자로 지정.
SELECT cc.column_name, c.constraint_name
FROM user_constraints c JOIN user_cons_columns cc
ON (c.constraint_name = cc.constraint_name)
WHERE c.table_name = 'EMP';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name IN ('DEPT','EMP');

--DML을 수행하며 제약조건 테스트하기
INSERT INTO emp
VALUES(null, '김수현','shkim@naver.com','01023456789','회사원',3500, null);

INSERT INTO emp
VALUES(1234, '김수현','shkim@naver.com','01023456789','회사원',3500, null);

INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,1800, 20);

INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,7800, 20);

COMMIT;

SELECT * FROM emp;

UPDATE emp
SET deptno=30
WHERE empno=1234;

UPDATE emp
SET deptno=10
WHERE empno=1234;

COMMIT;

DELETE FROM dept
WHERE deptno=10;

SELECT * FROM emp;

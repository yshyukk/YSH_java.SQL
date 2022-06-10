--���̺� ������ ����
CREATE TABLE dept (deptno   NUMBER(2),
         dname       VARCHAR2(14),
         loc         VARCHAR2(13));

DESC dept;

--�⺻�� �׽�Ʈ
    --�⺻Ű�� �������� ��� �߰���.
INSERT INTO dept(deptno, dname)
VALUES(10, '��ȹ��');

INSERT INTO dept
VALUES(20, '������', '����');

COMMIT;

SELECT * FROM dept;

ROLLBACK;

DESC employees;

--rowid : ���� ������ ������ ã����. (18�ڸ�)
SELECT employee_id, rowid
FROM employees;

-- �ش� ��� id�� rowid �� ��ȸ�ϸ� �ش� ����� ������ ����.
SELECT *
FROM employees
WHERE rowid = 'AAAE5oAAEAAAADMAAA';

-- ���� ���Ƶ� rowid�� �ٸ�.

SELECT deptno, dname, rowid
FROM dept;

DROP TABLE dept PURGE;

--�⺻Ű�� �⺻�� ���� �����ϴ� ���̺� ����
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY,
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE);

DROP TABLE dept;

CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY,
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE);
--�⺻�� �׽�Ʈ
INSERT INTO dpt(deptno, dname)
VALUES(10, '��ȹ��');

INSERT INTO dept
VALUES(20, '������', '����', '19/03/14');

COMMIT;

SELECT * FROM dept;

--�������� ���������� �����ϴ� ���̺� ����
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4)REFERENCES dept(deptno));

--�������� ���� ��ųʸ� ���� ���� (user_���ϴ� ����)
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';

-- ��ųʸ����� ������ �ִ� where������ �빮�ڷ� ����.
SELECT cc.column_name, c.constraint_name
FROM user_constraints c JOIN user_cons_columns cc
ON (c.constraint_name = cc.constraint_name)
WHERE c.table_name = 'EMP';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name IN ('DEPT','EMP');

--DML�� �����ϸ� �������� �׽�Ʈ�ϱ�
INSERT INTO emp
VALUES(null, '�����','shkim@naver.com','01023456789','ȸ���',3500, null);

INSERT INTO emp
VALUES(1234, '�����','shkim@naver.com','01023456789','ȸ���',3500, null);

INSERT INTO emp
VALUES(1223, '�ڳ���','nrpark@gmail.com','01054359876',null,1800, 20);

INSERT INTO emp
VALUES(1223, '�ڳ���','nrpark@gmail.com','01054359876',null,7800, 20);

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

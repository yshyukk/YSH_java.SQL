--<< INSERT hr1>>
INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700);
SELECT * FROM departments;
COMMIT;
--Ư���� �� �Է�
--SYSDATE �Է�
INSERT INTO employees 
VALUES		   (113,  'Louis', 'Popp', 'LPOPP', '515.124.4567', 
                        SYSDATE, 'AC_ACCOUNT', 6900,  NULL, 205, 110);
--TO_DATE �Լ� ���
INSERT INTO employees
VALUES      (114, 'Den', 'Raphealy', 'DRAPHEAL', '515.127.4561',
                      TO_DATE('02 03, 99', 'MM DD, YY'), 'SA_REP', 11000, 0.2, 100, 60);
INSERT INTO employees
VALUES      (115, 'Mark', 'Kim', 'MKIM', '515.127.4562',
                      TO_DATE('02 03, 99', 'MM DD, RR'),
                      'SA_REP', 13000, 0.25, 100, 60);             
SELECT * FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy/mm/dd') AS hire_date
FROM employees;
.
--�ٸ� ���̺�� �� ����

--AS������ ���̺� ������ sales_reps����
--DML �ϴٰ� DDL �����ϸ� ��� COMMIT��.-> COMMIT�� ��ü �����ϴ� �����̶� �� ������ �� �� �� ����.
CREATE TABLE sales_reps
AS
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees
WHERE 1=2;

desc sales_reps;

SELECT *
FROM sales_reps;

--ġȯ���� ���(40, Human Resource, 2500 �Է�)
INSERT INTO departments(department_id, department_name, location_id)
VALUES     (&department_id, '&department_name',&location);
COMMIT;

SELECT*FROM departments;

-- <UPDATE hr 1>>

UPDATE employees
SET salary= 7000;

SELECT * FROM employees;
ROLLBACK;



UPDATE employees
SET salary= 7000
WHERE employee_id = 104;

UPDATE   employees
SET      job_id  = (SELECT  job_id 
                              FROM    employees 
                              WHERE   employee_id = 205), 
             salary  = (SELECT  salary 
                             FROM    employees 
                              WHERE   employee_id = 205) 
WHERE    employee_id    =  113;

-- 115���� �μ���ȣ�� �μ��̸��� public�� �� �μ���ȣ�� ������Ʈ �ض�.
UPDATE employees
SET  department_id =
                                      (SELECT department_id
                                       FROM   departments
                                       WHERE  department_name LIKE '%Public%')
WHERE employee_id = 115;

COMMIT;

--<< DELETE >>
DELETE FROM departments
WHERE  department_name = 'Finance';

DELETE FROM employees
WHERE  department_id =
                                             (SELECT department_id
                                              FROM   departments
                                              WHERE  department_name LIKE '%Public%');

COMMIT;

DELETE FROM departments;

--<<DELETE �� TRUNCATE>>
SELECT * FROM sales_reps;

DELETE FROM sales_reps;

SELECT * FROM sales_reps;

ROLLBACK;

SELECT * FROM sales_reps;

--TRUNCATE TABLE : ���̺��� �����͸� ���� �����ϰ� ����ϰ� �ִ� ������ �ݳ�

TRUNCATE TABLE sales_reps;

SELECT * FROM sales_reps;

ROLLBACK;

SELECT * FROM sales_reps;

INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';

SELECT * FROM sales_reps;

COMMIT;

CREATE TABLE bigemp
AS
SELECT*FROM employees;

SELECT*FROM bigemp;

delete from bigemp;

Rollback;

INSERT INTO bigemp
SELECT*FROM bigemp;

commit;

UPDATE bigemp
SET salary = sal;ary*1.1;

rollback;

-- delete�� undo ����X
DELETE bigemp;
rollback;
-- TRUNCATE table�� ������ ���������� �����ʹ� X
TRUNCATE TABLE bigemp;

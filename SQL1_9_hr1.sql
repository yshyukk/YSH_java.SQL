--<< INSERT hr1>>
INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700);
SELECT * FROM departments;
COMMIT;
--특별한 값 입력
--SYSDATE 입력
INSERT INTO employees 
VALUES		   (113,  'Louis', 'Popp', 'LPOPP', '515.124.4567', 
                        SYSDATE, 'AC_ACCOUNT', 6900,  NULL, 205, 110);
--TO_DATE 함수 사용
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
--다른 테이블로 행 복사

--AS이하의 테이블 구조로 sales_reps생성
--DML 하다가 DDL 실행하면 즉시 COMMIT됨.-> COMMIT은 전체 저장하는 느낌이라 그 전까지 한 거 다 저장.
CREATE TABLE sales_reps
AS
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees
WHERE 1=2;

desc sales_reps;

SELECT *
FROM sales_reps;

--치환변수 사용(40, Human Resource, 2500 입력)
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

-- 115번의 부서번호를 부서이름에 public이 들어간 부서번호로 업데이트 해라.
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

--<<DELETE 와 TRUNCATE>>
SELECT * FROM sales_reps;

DELETE FROM sales_reps;

SELECT * FROM sales_reps;

ROLLBACK;

SELECT * FROM sales_reps;

--TRUNCATE TABLE : 테이블의 데이터를 전부 삭제하고 사용하고 있던 공간을 반납

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

-- delete는 undo 생성X
DELETE bigemp;
rollback;
-- TRUNCATE table의 구조는 남아있지만 데이터는 X
TRUNCATE TABLE bigemp;

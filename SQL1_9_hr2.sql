--<< INSERT hr2>>
SELECT * FROM departments;

--컬럼이 총 4개지만 2개만 입력도 가능
INSERT INTO	departments (department_id, department_name)
VALUES		(30, 'Purchasing');

-- 위 경우에 table 뒤 컬럼을 입력하지않으면 나머지 2 컬럼의 값은 NULL
INSERT INTO	departments
VALUES		(100, 'Finance', NULL, NULL);

SELECT * FROM departments;

-- TRANSACTION 종료
-- 진행중인 TRASACTION은 현재 사용중인 유저에게만 보인다.
-- COMMIT되지 않은 데이터는 공유하지 않는다. (일반성)
COMMIT;

SELECT * FROM employees;

--2번 HR
SELECT * FROM employees;


SELECT * FROM sales_reps;

--INSERT INTO table~SELECT : table에 SELECT 컬럼 몽땅 복붙.

INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';

SELECT * FROM sales_reps;

COMMIT;

--<< UPDATE hr 2 >>
UPDATE employees
SET salary= salary*1.1
WHERE employee_id = 104;

ROLLBACK;



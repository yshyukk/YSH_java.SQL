SELECT *
FROM job_history;

-- SELECT문 하나가 집합 하나
-- UNION은 [ALL]을 작성하지 않으면 중복제거

SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, department_id FROM job_history;

--컬럼수가 다르면 실행 X
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id FROM job_history;

--컬럼이름이 같아야 하는건 아니지만  
--두 SELECT문에 입력하는 열의 타입이 순서대로 같아야 함.
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, job_id FROM job_history;

-- UNION은 중복제거 해야하므로 ORDER BY절 쓰지 않아도 사원번호기준으로 정렬됨.
-- 정렬 해야하는데 또 해야 하므로 ORDER BY절은 쓰지 말자.
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, department_id FROM job_history
ORDER BY 1;

-- 별칭은 첫번째 문장에서 주어야 적용 됨.
-- 중복찾을 필요 없으니까 ALL은 정렬하지 않음.
SELECT employee_id 사원번호, department_id FROM employees
UNION ALL
SELECT employee_id, department_id 부서번호 FROM job_history;

--INTERSECT : 교집합
-- 예전에 있던 부서와 현재 부서가 같은 사람.
SELECT employee_id, department_id FROM employees
INTERSECT
SELECT employee_id, department_id FROM job_history;

--MINUS : 차집합
--입사 후 부서가 변경되지 않은 사람
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;


--입사 후 한번도 부서 변경되지 않은 사람의 사번, 성, 부서명
SELECT employee_id, last_name, job_id
FROM employees
WHERE employee_id IN
                                (SELECT employee_id FROM employees
                                MINUS
                                SELECT employee_id FROM job_history);

-- 퇴사한 직원
SELECT employee_id FROM  job_history
MINUS
SELECT employee_id FROM employees;

-- 억지로 맞춰주는 방법.
SELECT employee_id,job_id FROM job_history
UNION
SELECT employee_id, TO_CHAR(null) FROM employees;

--COLUMN수와 DATATYPE 매칭시키기 응용

--부서내 직업명이 같은 사람의 부서수와 총 급여?
SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id, job_id;

-- 사원수와 총 급여?
SELECT department_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id;

SELECT COUNT(*), SUM(salary)
FROM employees;


SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id, job_id
UNION
SELECT department_id, TO_CHAR(null), COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id
UNION
SELECT TO_NUMBER(null), TO_CHAR(null), COUNT(*), SUM(salary)
FROM employees
ORDER BY 1,2;

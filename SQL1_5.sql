--GROUP 함수의 기본 사용
SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees;

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees
WHERE  department_id = 60;

SELECT MIN(last_name), MAX(last_name)
FROM employees;

SELECT MIN(hire_date), MAX(hire_date)
FROM employees;


--COUNT만 *와 distinct 사용할 수 있음.

SELECT COUNT(*), COUNT(department_id), COUNT(DISTINCT department_id)
FROM employees;

--group함수는 null값을 빼고 계산하므로 null값을 0으로 하고 포함해서 계산하기위해 NVL사용
SELECT AVG(commission_pct), AVG(NVL(commission_pct, 0))
FROM employees;


--GROUP BY 절의 사용

SELECT department_id, SUM(salary), COUNT(*)
FROM employees;

--group by절에 있는 column만 select절에 올수있음.
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id
ORDER BY 1; --ORDER BY절은 항상 마지막에!!

-- 부서번호로 구분, 같은 부서내에서도 업무가 같은 사람들로 그룹.
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1,2;

-- 실행순서 [  FROM --> WHERE --> GROUP BY --> SELECT --> ORDER BY ]
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id >= 50
GROUP BY department_id, job_id
ORDER BY 1,2;

--HAVING 절의 사용

SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE COUNT(*) <> 1 -- where절은 행을 선택하는 기능! , 그룹을 정하지도 않았는데 그룹함수사용은 못한다.
GROUP BY department_id, job_id
ORDER BY 1,2;

SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id <> 90   --WHERE절은 GROUP BY절 위에
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1    -- HAVING절 : 그룹을 선택하는 기능. // GROUP BY절이 없는데 HAVING절이 나올 수 없음.
ORDER BY 1,2;               

--GROUP 함수의 중첩 (최대 2번)

SELECT MAX(SUM(salary))
FROM employees
GROUP BY department_id;
SELECT department_id, MAX(SUM(salary))
FROM employees
GROUP BY department_id;
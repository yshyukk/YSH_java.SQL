--GROUP �Լ��� �⺻ ���
SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees;

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees
WHERE  department_id = 60;

SELECT MIN(last_name), MAX(last_name)
FROM employees;

SELECT MIN(hire_date), MAX(hire_date)
FROM employees;


--COUNT�� *�� distinct ����� �� ����.

SELECT COUNT(*), COUNT(department_id), COUNT(DISTINCT department_id)
FROM employees;

--group�Լ��� null���� ���� ����ϹǷ� null���� 0���� �ϰ� �����ؼ� ����ϱ����� NVL���
SELECT AVG(commission_pct), AVG(NVL(commission_pct, 0))
FROM employees;


--GROUP BY ���� ���

SELECT department_id, SUM(salary), COUNT(*)
FROM employees;

--group by���� �ִ� column�� select���� �ü�����.
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id
ORDER BY 1; --ORDER BY���� �׻� ��������!!

-- �μ���ȣ�� ����, ���� �μ��������� ������ ���� ������ �׷�.
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1,2;

-- ������� [  FROM --> WHERE --> GROUP BY --> SELECT --> ORDER BY ]
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id >= 50
GROUP BY department_id, job_id
ORDER BY 1,2;

--HAVING ���� ���

SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE COUNT(*) <> 1 -- where���� ���� �����ϴ� ���! , �׷��� �������� �ʾҴµ� �׷��Լ������ ���Ѵ�.
GROUP BY department_id, job_id
ORDER BY 1,2;

SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id <> 90   --WHERE���� GROUP BY�� ����
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1    -- HAVING�� : �׷��� �����ϴ� ���. // GROUP BY���� ���µ� HAVING���� ���� �� ����.
ORDER BY 1,2;               

--GROUP �Լ��� ��ø (�ִ� 2��)

SELECT MAX(SUM(salary))
FROM employees
GROUP BY department_id;
SELECT department_id, MAX(SUM(salary))
FROM employees
GROUP BY department_id;
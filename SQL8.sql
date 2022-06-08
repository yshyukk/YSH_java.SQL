SELECT *
FROM job_history;

-- SELECT�� �ϳ��� ���� �ϳ�
-- UNION�� [ALL]�� �ۼ����� ������ �ߺ�����

SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, department_id FROM job_history;

--�÷����� �ٸ��� ���� X
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id FROM job_history;

--�÷��̸��� ���ƾ� �ϴ°� �ƴ�����  
--�� SELECT���� �Է��ϴ� ���� Ÿ���� ������� ���ƾ� ��.
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, job_id FROM job_history;

-- UNION�� �ߺ����� �ؾ��ϹǷ� ORDER BY�� ���� �ʾƵ� �����ȣ�������� ���ĵ�.
-- ���� �ؾ��ϴµ� �� �ؾ� �ϹǷ� ORDER BY���� ���� ����.
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, department_id FROM job_history
ORDER BY 1;

-- ��Ī�� ù��° ���忡�� �־�� ���� ��.
-- �ߺ�ã�� �ʿ� �����ϱ� ALL�� �������� ����.
SELECT employee_id �����ȣ, department_id FROM employees
UNION ALL
SELECT employee_id, department_id �μ���ȣ FROM job_history;

--INTERSECT : ������
-- ������ �ִ� �μ��� ���� �μ��� ���� ���.
SELECT employee_id, department_id FROM employees
INTERSECT
SELECT employee_id, department_id FROM job_history;

--MINUS : ������
--�Ի� �� �μ��� ������� ���� ���
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;


--�Ի� �� �ѹ��� �μ� ������� ���� ����� ���, ��, �μ���
SELECT employee_id, last_name, job_id
FROM employees
WHERE employee_id IN
                                (SELECT employee_id FROM employees
                                MINUS
                                SELECT employee_id FROM job_history);

-- ����� ����
SELECT employee_id FROM  job_history
MINUS
SELECT employee_id FROM employees;

-- ������ �����ִ� ���.
SELECT employee_id,job_id FROM job_history
UNION
SELECT employee_id, TO_CHAR(null) FROM employees;

--COLUMN���� DATATYPE ��Ī��Ű�� ����

--�μ��� �������� ���� ����� �μ����� �� �޿�?
SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id, job_id;

-- ������� �� �޿�?
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

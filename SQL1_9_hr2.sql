--<< INSERT hr2>>
SELECT * FROM departments;

--�÷��� �� 4������ 2���� �Էµ� ����
INSERT INTO	departments (department_id, department_name)
VALUES		(30, 'Purchasing');

-- �� ��쿡 table �� �÷��� �Է����������� ������ 2 �÷��� ���� NULL
INSERT INTO	departments
VALUES		(100, 'Finance', NULL, NULL);

SELECT * FROM departments;

-- TRANSACTION ����
-- �������� TRASACTION�� ���� ������� �������Ը� ���δ�.
-- COMMIT���� ���� �����ʹ� �������� �ʴ´�. (�Ϲݼ�)
COMMIT;

SELECT * FROM employees;

--2�� HR
SELECT * FROM employees;


SELECT * FROM sales_reps;

--INSERT INTO table~SELECT : table�� SELECT �÷� ���� ����.

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



--JOIN�̶�??
--����ȭ : �ߺ����� ���� ���� ���̺��� �������� ����
--������ȭ : ����ȭ�� ����� ���� ���̺���� ��ħ

SELECT employee_id, last_name, salary, department_id, department_name
FROM employees JOIN departments
USING (department_id); --�� ���̺� JOIN�Ҷ� �μ���ȣ�� �̿��ض� (��� �� column�� ������ �־�ߵ�.)

--JOIN(����)
    --NATURAL JOIN
    --JOIN~USING
    --JOIN~ON
    --[LEFT | RINGHT | FULL] OUTER JOIN
    

--NATURAL JOIN
SELECT * 
FROM departments;

SELECT * 
FROM locations;

SELECT department_id, department_name, location_id, city
FROM departments NATURAL JOIN locations;    

SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;    --����� �μ��� NATURAL JOIN �Ұ�
                                                                        -- �����̺��� ���� �÷��� 1���϶� ��� / �÷������ ���� �� ����.

--USING ���� ����ϴ� JOIN
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);

SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id);

--ON���� ����ϴ� JOIN : �÷����� �ٸ� ���̺��� JOIN�Ҷ�
SELECT employee_id, last_name, department_id, department_name   --department_id �̰� �������� ���� ����! �Ʒ�ó�� �ٲ����.
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);

SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id); -- �÷����� �ٸ� ���̺��� JOIN�Ҷ� �� ���̺��� ����.


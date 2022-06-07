SELECT salary            --salary ���� ����                   
FROM employees      --emplyees ���̺���          
WHERE last_name = 'Grant';  -- last_name�� Grant�� ������

SELECT *                --��� �÷�����
FROM employees     -- employees ���̺� ��
WHERE salary > 7000;    --salary�� 7000 �̻��� ������

-- ��������
    --GROUP BY�������� ��� X
SELECT *
FROM employees
WHERE salary > (SELECT salary          		--> �� ���������� ����� = 7000
                        FROM employees
                        WHERE last_name = 'Grant')
AND hire_date < (SELECT hire_date		-- GRANT���� ���� �Ի��ϰ� GRANT���� ���� ���� �޴� ���.
                         FROM employees		--  date�� �����ϼ��� �۾���. 	
                         WHERE last_name='Grant');
                        
--Subquery�� �⺻ ���
SELECT salary 
FROM employees
WHERE last_name = 'Abel';

SELECT *
FROM employees
WHERE salary > 11000;

SELECT *
FROM employees
WHERE salary > (SELECT salary 
                             FROM employees
                            WHERE last_name = 'Abel');
                            
--������ ��������(Single Row Subquery) : ���������� ���� �����ߴµ� �ϳ��� ������
    -- ���������� ���������� ���̿� �񱳿����ڸ� ����ϱ� ���� = �񱳿����ڴ� �������� > ������ ���������� ��� ����
SELECT last_name, job_id, salary
FROM   employees    --Matos�� job_id�� ���� salary�� ���� ���� ã��.
WHERE  job_id =  
                             (SELECT job_id     --Job_id �ϳ��� �����ϱ� ������ ����
                              FROM   employees
                              WHERE  last_name = 'Matos')
AND    salary >
                             (SELECT salary -- salary �ϳ��� �����ϱ� ������ ����
                              FROM   employees
                              WHERE  last_name = 'Matos');

SELECT MAX(salary) -- salary�� ���� ���� ���
FROM employees;

SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees);
                              
 --HAVING�� : GROUP BY�� ���� ��� X, GROUP�� �����ϴ� ���.
 --20�� �μ����� �ο��� ���� �μ� ã��.
SELECT   department_id, COUNT(*)
FROM     employees
GROUP BY department_id
HAVING  COUNT(*) > (SELECT COUNT(*)    
                                         FROM   employees
                                         WHERE  department_id = 20);      
                                        
-- 60���� �μ����� ���� �޿��� ���� ����� ������ �޿��� �޴� ���                                         
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                             WHERE department_id = 60);
                            
--���� �� ��������(Multiple Row Subquery)    

SELECT MAX(salary) 
FROM employees
GROUP BY department_id;

-- `=`�� ����߱⶧���� ������ ������ ���´ٰ� ��������� ���������� �������̱� ������ ������.
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                              GROUP BY department_id);    

--    ������              ������
--      =           ->      IN
--      <>         ->       NOT IN
--        >      ---
--        >=    ---       +     ANY
--        <      ---        +    ALL
--        <=   ----



-- '='��� IN�� ���.
SELECT last_name, job_id, salary
FROM   employees
WHERE salary IN (SELECT MAX(salary) 
                               FROM employees
                              GROUP BY department_id);  

SELECT salary 
FROM employees
WHERE department_id = 60;       

SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary 
                              FROM employees
                             WHERE department_id = 60)
AND department_id <> 60;      

-- 60������ ū �ƹ��ų�
--  AND department_id <> 60;  ���������� 60���� �˻��ϴϱ�!
-- ANY�� or ����
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ANY (SELECT salary 
                                      FROM employees
                                      WHERE department_id = 60)
AND department_id <> 60; 

SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ALL (SELECT salary 
                                    FROM employees
                                    WHERE department_id = 60)
AND department_id <> 60;


--Subquery ��� �� ���ǻ���
--Sub������ �ƹ��͵� ��ȯ���� ������ main������ �ƹ��͵� ��ȯ���� ����.
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary
                              FROM employees
                              WHERE last_name = 'Mark');

--���������� ���� �Ŵ��� ã��
SELECT employee_id, last_name
FROM employees 
WHERE employee_id IN (SELECT manager_id
                                           FROM employees);
-- ���������� ���� �Ŵ��� ã��
 -- ()���� OR --> OR �� �ٽ� NOT�ϹǷ� ��������� AND 
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees);    
                                              
-- IN�� =�� ������ѳ��� ��. NULL�� ���� ���� ���� ���� ���⶧���� NULL�� = ������ ����ϸ� ��ȯ�ϴ°� ����.                                                  
SELECT *
FROM employees
WHERE manager_id IN (100,101,NULL);

--  WHERE manager_id IS NOT NULL�� �߰��� NULL���� �ƴ� ������ �߰��ؾ���.
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees
                                                     WHERE manager_id IS NOT NULL);  

--DESC�� ���̺�����
DESC employees;

select last_name, email, job_id
from employees;

select upper (last_name),Lower( email), initcap( job_id)
From employees;

select upper (oracle SYS.database_name),Lower( email), initcap( job_id)
From employees;

select upper(oracle SYS.database_name) lowd,date;
from dual;

select 1234+3212
from dual;

select employee_id, concat(first_name, last_name) as fullname, salary
from employees;

select employee_id, concat(concat(first_name, ' '), last_name) as fullname, salary
from employees;

select employee_id, last_name, concat(email,'@yd.com') as email_addr
from employees;


--substr
select substr('oracle database', 1,6) -- �ҽ����� ù��° �����Ϳ��� 6���ڸ� ����ض�.
from dual;

select substr('oracle database', 1,6), substr('oracle database', 8,4)
from dual;

select substr('oracle database', 1,6), substr('oracle database', 8,4), substr('oracle database', 8)
from dual; --> 3��° �μ� �����ϸ� 2��° �μ� �ڷ� �� ���


select substr('oracle database', 1,6), substr('oracle database', 8,4), substr('oracle database', 8),
         substr('oracle database',-4,4)
from dual;

select employee_id, last_name, substr(last_name,1,3)
from employees
where substr(last_name,-1,1)='s';

select employee_id, last_name, substr(last_name,1,3)
from employees
where last_name like '%s';  --> ������� ����

--length
select employee_id, last_name, length(last_name)
from employees; -- �����Լ����� (=�μ��� ����) ����� ���ڷ�

select length('oracle database'), length('����Ŭ �����ͺ��̽�')
from dual;

select lengthb('oracle database'), lengthb('����Ŭ �����ͺ��̽�')
from dual; -- lengthb : �������� ũ�� ��

--INSRT
select employee_id, last_name, instr(last_name, 'a')
from employees; -- last_name�� �����͵�ȿ��� a�� ���°�� ��������

select *
from employees
where instr(last_name, 'a')=0;

select *
from employees
where last_name not like '%a%'; --- ���� ���� ���

--RPAD, LPAD //  L=�������� ������, R=�������� �������� ,PAD= (���� ������)ä����

select employee_id, RPAD(last_name,7,'*'), LPAD(salary, 15, '*') 
from employees;

--trim ���ξ� ���̾� �߶��!

SELECT TRIM('o' FROM 'oracle database') -- oracle database���� o�� �߶�� (���ξ ���̾ �ڸ��� ����.)
FROM dual;

SELECT TRIM('w' FROM 'window'), --���ξ� ���̾� �Ѵ�
           TRIM(LEADING 'w' FROM 'window'), -- ���ξ
           TRIM(TRAILING 'w' FROM 'window') -- ���̾
FROM dual;

SELECT employee_id, last_name,
           Concat('+82' , TRIM(LEADING '0' FROM phone_number))
From empolyees;

SELECT TRIM('0' from '000000123001122')
from dual;

SELECT TRIM('01' from ' 010101010101123001122 ')
from dual;  -- ''�ȿ��� 0 �ϳ��� �����.

SELECT LTRIM('01' from '010101010101123001122', '01')
from dual;

--REPLACE

SELECT REPLACE('Jack and Jue', 'J', 'Bl')
FROM dual;

select employee_id, last_name,
         replace(last_name, substr(last_name, 2,2) , '**')
from employees;

---------
select *
from employees
where LOWER(last_name) ='king'; -- > �ҹ��ڷ� �Է��ص� �빮�� ã��

--------- <���� �Լ�>

-- ROUND(�μ�, �ڸ���)    �ڸ��� +�� : �Ҽ����Ʒ�/ ����: ������/ -�� : 10���ڸ��� ===>�ݿø�
SELECT ROUND(45.923,2), ROUND(45.923), ROUND(45.923,-1)
FROM   DUAL;


-- TRUNC ===> ����
SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923,-1)
FROM   DUAL;

-- MOD (����������, ������)===> ������ ����
SELECT last_name, salary, MOD(salary, 5000)
FROM   employees
WHERE  job_id = 'SA_REP';

---------��¥ ����  RR/mm/dd

--sysdate ==�μ�X, ���� ��¥ (������ �ִ� ��ǻ���� ��¥)
SELECT sysdate 
FROM dual;

SELECT sysdate, sysdate+10 
FROM dual;

SELECT employee_id, last_name, hire_date, sysdate-hire_date AS �ٹ��ϼ�
FROM employees;

SELECT employee_id, last_name, hire_date, 
              TRUNC(sysdate-hire_date) AS �ٹ��ϼ�
FROM employees; --> �Ϸ簡 �ȵǴ� ��¥�� �����ϰ� �ϼ�

SELECT last_name, ROUND((SYSDATE-hire_date)/7) AS WEEKS
FROM   employees
WHERE  department_id = 90;  --> �Ϸ� �����̻� ������ �ϼ��� ���� 


--��¥�Լ�

--MONTHS_BETWEEN

SELECT employee_id, last_name, 
              MONTHS_BETWEEN(sysdate, hire_date)AS �ٹ��Ⱓ
FROM employees;


SELECT employee_id, last_name, 
              TRUNC(MONTHS_BETWEEN(sysdate, hire_date))AS �ٹ��Ⱓ
FROM employees;

--ADD_MONTHS, LAST_DAY
SELECT ADD_MONTHS(sysdate, 3), LAST_DAY(sysdate)
FROM dual;


--NEXT_DAY
SELECT NEXT_DAY(sysdate, '�ݿ���'), NEXT_DAY(sysdate, '��'),
               NEXT_DAY(sysdate, 6) -- �Ͽ���(1)~��~(7)
FROM dual;      

SELECT NEXT_DAY(sysdate, 'FRIDAY') 
FROM dual; --���� �� �����.

--ROUND
    --year : ������ 1��1�Ϸ� ����, ������ ������ ���������� ����, �ƴϸ� ����
    --month : �Ѵ��� ����, ������ 1�Ϸ� ����.   
    --dd : �׻� 0�÷� ����.
    --day : 1���� ,������ �Ͽ��Ϸ� ����. ������ 12:00 ���̸� ���� �� �Ͽ���, �ĸ� �̹� �� �Ͽ��� 

SELECT sysdate, ROUND(sysdate, 'year'), ROUND(sysdate, 'month'), 
              ROUND(sysdate, 'dd'), ROUND(sysdate, 'day')
FROM dual;       

--TRUNC : �ð��� �ݿø����� �ʰ� ������ ������ ������ ���� 
SELECT sysdate, TRUNC(sysdate, 'year'), TRUNC(sysdate, 'month'), 
       TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'day')
FROM dual;

--Q. ������̺��� �Ի��� (hire_date)�� �̿��Ͽ� ����� �Ի� �� ù �޿��ϰ� ������������ ���Ͻÿ�.
--  ù �޿��� : �Ի��� ������ 5��
-- ���� ������ : �Ի� �� 3���� �� ó�� �����ϴ� �ݿ��� �Դϴ�.

select employee_id, last_name, hire_date,
         LAST_DAY(hire_date)+5 "ù �޿���",
         NEXT_DAY(ADD_MONTHS (hire_date,3), '�ݿ���') "������"
From employees;


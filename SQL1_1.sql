SELECT * 
FROM employees;

SELECT *
FROM departments;

SELECT location_id, department_name
from departments;

--ǥ����(expression) : �ַ� �������(+,-,*,/)
select employee_id, last_name, salary*12
from employees;
select employee_id, last_name, salary+100*12, (salary+100)*12
from employees;
--1. coulmn �Ǵ� ǥ���� ������ (as) ���ϴ� coulmn�� 
--2. ���ϴ� coulmn�� �ۼ��Ҷ� ����X(���� �ڸ��� _���), ������ Ư����ȣ ó����.
--    ������ ����ϰų� �ҹ��ڷ� ����ϰ������ " "�� ��� ���ϴ´�� ���ֱ�
select employee_id, last_name, salary*12 AS annual_salary --1.
from employees;
select employee_id, last_name, salary, salary*12  "Annual Salary" --2.
from employees;

--���Ῥ����(��ȣ : ||) :column�� �����ؼ� ������.
select employee_id, first_name, last_name
from employees;

select employee_id, first_name||last_name
from employees;

select employee_id, 
         first_name||last_name full_name
from employees;

select employee_id, 
         first_name || ' ' || last_name full_name -- �̸����̿� ����ֱ�. ������ ���ڷ� ��� ''��
from employees;

select employee_id, 
         first_name || ' ' || last_name full_name, email || '@yd.com' as email --���� ������ email�� ,����Ҷ��� @yd.com��� 
from employees;

select last_name || '''s salary : ' || salary -- '<-- ���� ������� �����ȳ���
from employees;

select last_name || q'['s salary : ]' || salary -- '<-- q�� ''���̰� �ȿ� ����ϰ���� ������ ǥ�����ָ� �����ȳ�.
from employees;                                -- �ᱹ ������ `��������Ͱ� ����.

--DISTINCT: �ߺ�����= �ߺ��Ǵ� column�� ����
SELECT department_id
from employees;

SELECT distinct department_id --*****select �ٷ� �ڿ����� ��� ����, �ѹ��� ��밡��
from employees;

SELECT distinct department_id, job_id --�ΰ��߿� ���� �ϳ��� ���� ���� ����X = �ΰ��� �ϳ��� ���� �Ѵ� ���� ���� �ߺ�üũ
from employees;

-- null��(�ƹ��͵� ������� ���� ����, 0 �Ǵ� ����� �ٸ� ����
select employee_id, last_name, manager_id, commission_pct, department_id
from employees;

select employee_id, last_name, salary, commission_pct, --null�� ����ϸ� null�� �ȴ�.
         salary + salary*commission_pct as �Ǳ޿�
from employees;

--���̺���(������) 
describe employees;
desc departments;
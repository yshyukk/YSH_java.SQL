select employee_id, last_name, hire_date, 
         salary, department_id
from employees;

--where ���� �⺻ ����

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id > 50; ----department_id�� 50�� �͸� ã�ƶ� / '=,>,<, <=, >=' : �񱳿�����, '50' : ���

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id <> 50; -- '<>' = �����ʴ�.

-- ���ڵ����� ��
select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name = 'King'; -- ���ڴ� '', ��ҹ���, ������� ��ġ // ""�� ��Ī�ۿ� ����.

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name <> 'King';


select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name > 'King';   -- ���� ��ұ����� ���ĺ��������

-----��¥ ������ ��

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where hire_date = '97/09/17'; -- ��¥�� ���ڿ� ������ ������ ���� ���� ����.

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where hire_date = '1997/09/17'; --ǥ���� 97/09/17�� �Ǿ� ������ , 1997/09/17�� ����

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where hire_date = '1997-09-17'; 

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where hire_date > '97-09-17'; -- >�� �� ��¥���� �� // ��¥�� �ķΰ����� Ŀ��.

---SQL�񱳿�����( IN/ LIKE/ BETWEEN/ IS NULL)

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id IN(50,60); --���߿� �ϳ��� ���� ������ / ��� �������.

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name IN('De Haan', 'Abel');

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('K%'); --like���� �� '%' /database���� ���ϵ�ī��� % / K �����ϴ� ����� �˻�.
                                      -- %�տ��� 0�� �̻��� ���ڸ� ��ü.
                                      
select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('%a%'); -- ��ġ������� �ҹ��� a�� ���ִ� ���                                       

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('%s'); -- s�� ������ ��� 

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('_a%'); -- _��ĭ�� �ѹ��� 

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('____'); -- _x4 : 4������ ������ ã��

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where job_id like 'IT\_%' escape '\'; --\�ڿ� �ѹ��ڸ� ���ϵ�ī��� ������� �ʰڴ�.(����ó��)
                                                    --'_'�� ���Ե� ������ �˻��Ҷ� ���
                                                    
--<between>

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where salary between 6000 and 9000; -- salary�� 6000 �̻� 9000 ������ ������, (��谪 �����ؼ� ����=�̻�,����)

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where last_name between 'Abel' and 'King'; -- ���ڰ˻��Ҷ��� ���ĺ� ������� �˻�

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where hire_date between '99/01/01' and '99/12/31';

--<is null> 

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where department_id = null; -- null�� ���ڿ�x, �׳� null

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where department_id is null; -- null�� ã������ '='��� ���� �ʰ� is!!!

--where���� �� ���忡 �ѹ��ۿ� ��� ���� ===> ������ (and, or ��..)�� ���

-- �������� (AND/ OR/ NOT)
select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where department_id IN (50,60,80)
AND salary > 9000;

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where department_id IN (50,60,80)
OR salary > 9000;

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where (department_id = 50
or department_id = 60)
and salary > 8000; --�������� �켱���� AND > OR , OR���� ����ؾ��Ҷ��� ()��

--NOT: IN/LIKE/BETWEEN�� ����, is null �� in not null
select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name not like('K%');

--����� ����(ORDER BY ���� ���)

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id  is not null
order by  salary DESC; -- DESC�� ��������, ���������� ����Ʈ. 

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id  is not null
order by  last_name;

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id  is not null
order by  hire_date DESC;

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id  is not null
order by department_id, salary DESC; --��������, ���������� �����Ϸ��� ���� �ؾ���.

select employee_id, last_name, hire_date, salary*12 as ����,  department_id
from employees
where department_id  is not null
order by  department_id, salary*12;


select employee_id, last_name, hire_date, salary*12 as ����,  department_id
from employees
where department_id  is not null
order by  5,4 desc; -- position number, 5,4= colume ��ȣ, ��Ī�� ����
                           -- order by���� �׻� ��������

select employee_id, last_name, hire_date, salary*12 as ����,  department_id
from employees
where salary*12 > 120000 --where������ ��ĪX
order by  5,4 desc;
-- ġȯ����
select employee_id, last_name, salary
from employees
where department_id =&�μ���ȣ; --&�����̸� 

select employee_id, last_name, salary
from employees
where last_name = '&����̸�'; -- �˻��Ҷ� ''���̰ų�, ������ '&����̸�'
                                            

select employee_id, last_name, salary, &coulmn_name --  ġȯ������ ���� ����� �� ����.
from employees;


select employee_id, last_name, salary, &coulmn_name
from employees
order by &coulmn_name;  -- ġȯ���� ������ ��� ����, ���� �̸��̶� ����.

select employee_id, last_name, salary, &&coulmn_name -- && : ���� ������ �����鼭 ���� �̸��� �ٸ� �������� ���� ���� ����.
from employees
order by &coulmn_name;

define coulmn_name;
undefine coulmn_name;



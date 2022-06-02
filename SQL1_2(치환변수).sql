-- 치환변수
select employee_id, last_name, salary
from employees
where department_id =&부서번호; --&변수이름 

select employee_id, last_name, salary
from employees
where last_name = '&사원이름'; -- 검색할때 ''붙이거나, 변수에 '&사원이름'
                                            

select employee_id, last_name, salary, &coulmn_name --  치환변수는 어디든 사용할 수 있음.
from employees;


select employee_id, last_name, salary, &coulmn_name
from employees
order by &coulmn_name;  -- 치환변수 여러개 사용 가능, 같은 이름이라도 가능.

select employee_id, last_name, salary, &&coulmn_name -- && : 값을 가지고 있으면서 같은 이름의 다른 변수에게 같은 값을 전달.
from employees
order by &coulmn_name;

define coulmn_name;
undefine coulmn_name;



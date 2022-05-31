SELECT * 
FROM employees;

SELECT *
FROM departments;

SELECT location_id, department_name
from departments;

--표현식(expression) : 주로 산술연산(+,-,*,/)
select employee_id, last_name, salary*12
from employees;
select employee_id, last_name, salary+100*12, (salary+100)*12
from employees;
--1. coulmn 또는 표현식 다음에 (as) 원하는 coulmn명 
--2. 원하는 coulmn명 작성할때 공백X(띄어쓰는 자리에 _사용), 공백은 특수기호 처리됨.
--    공백을 사용하거나 소문자로 출력하고싶을때 " "로 묶어서 원하는대로 써주기
select employee_id, last_name, salary*12 AS annual_salary --1.
from employees;
select employee_id, last_name, salary, salary*12  "Annual Salary" --2.
from employees;

--연결연산자(기호 : ||) :column을 연결해서 보여줌.
select employee_id, first_name, last_name
from employees;

select employee_id, first_name||last_name
from employees;

select employee_id, 
         first_name||last_name full_name
from employees;

select employee_id, 
         first_name || ' ' || last_name full_name -- 이름사이에 공백넣기. 공백은 문자로 취급 ''로
from employees;

select employee_id, 
         first_name || ' ' || last_name full_name, email || '@yd.com' as email --실제 저장은 email만 ,출력할때만 @yd.com출력 
from employees;

select last_name || '''s salary : ' || salary -- '<-- 갯수 맞춰줘야 오류안나요
from employees;

select last_name || q'['s salary : ]' || salary -- '<-- q를 ''붙이고 안에 출력하고싶은 범위를 표시해주면 오류안남.
from employees;                                -- 결국 위에서 `갯수맞춘것과 동일.

--DISTINCT: 중복제거= 중복되는 column을 제거
SELECT department_id
from employees;

SELECT distinct department_id --*****select 바로 뒤에서만 사용 가능, 한번만 사용가능
from employees;

SELECT distinct department_id, job_id --두개중에 값이 하나만 같은 것은 제거X = 두개를 하나로 보고 둘다 같은 것을 중복체크
from employees;

-- null값(아무것도 저장되지 않은 상태, 0 또는 공백과 다른 상태
select employee_id, last_name, manager_id, commission_pct, department_id
from employees;

select employee_id, last_name, salary, commission_pct, --null은 계산하면 null이 된다.
         salary + salary*commission_pct as 실급여
from employees;

--테이블구조(열구조) 
describe employees;
desc departments;
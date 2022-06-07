select employee_id, last_name, hire_date, 
         salary, department_id
from employees;

--where 절의 기본 사용법

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id > 50; ----department_id가 50인 것만 찾아라 / '=,>,<, <=, >=' : 비교연산자, '50' : 상수

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id <> 50; -- '<>' = 같지않다.

-- 문자데이터 비교
select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name = 'King'; -- 문자는 '', 대소문자, 공백까지 일치 // ""는 별칭밖에 없음.

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name <> 'King';


select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name > 'King';   -- 문자 대소구분은 알파벳순서대로

-----날짜 데이터 비교

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where hire_date = '97/09/17'; -- 날짜는 문자와 숫자의 성질을 같이 갖고 있음.

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where hire_date = '1997/09/17'; --표현은 97/09/17로 되어 있지만 , 1997/09/17도 가능

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where hire_date = '1997-09-17'; 

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where hire_date > '97-09-17'; -- >는 그 날짜보다 후 // 날짜는 후로갈수록 커짐.

---SQL비교연산자( IN/ LIKE/ BETWEEN/ IS NULL)

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id IN(50,60); --둘중에 하나가 같은 데이터 / 몇개든 상관없음.

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name IN('De Haan', 'Abel');

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('K%'); --like사용시 꼭 '%' /database에서 와일드카드는 % / K 시작하는 사람을 검색.
                                      -- %앞에는 0개 이상의 문자를 대체.
                                      
select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('%a%'); -- 위치상관없이 소문자 a가 들어가있는 사람                                       

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('%s'); -- s로 끝나는 사람 

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('_a%'); -- _한칸은 한문자 

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name like('____'); -- _x4 : 4글자인 데이터 찾기

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where job_id like 'IT\_%' escape '\'; --\뒤에 한문자만 와일드카드로 사용하지 않겠다.(예외처리)
                                                    --'_'가 포함된 데이터 검색할때 사용
                                                    
--<between>

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where salary between 6000 and 9000; -- salary가 6000 이상 9000 이하인 데이터, (경계값 포함해서 나옴=이상,이하)

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where last_name between 'Abel' and 'King'; -- 문자검색할때는 알파벳 순서대로 검색

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where hire_date between '99/01/01' and '99/12/31';

--<is null> 

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where department_id = null; -- null은 문자열x, 그냥 null

select employee_id, last_name, hire_date,
         salary, department_id, job_id
from employees
where department_id is null; -- null을 찾을때는 '='사용 하지 않고 is!!!

--where절은 한 문장에 한번밖에 사용 못함 ===> 논리연산 (and, or 등..)을 사용

-- 논리연산자 (AND/ OR/ NOT)
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
and salary > 8000; --논리연산자 우선순위 AND > OR , OR먼저 사용해야할때는 ()로

--NOT: IN/LIKE/BETWEEN의 부정, is null 은 in not null
select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where last_name not like('K%');

--결과를 정렬(ORDER BY 절의 사용)

select employee_id, last_name, hire_date, 
         salary, department_id
from employees
where department_id  is not null
order by  salary DESC; -- DESC는 내림차순, 오름차순은 디폴트. 

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
order by department_id, salary DESC; --오름차순, 내림차순을 정렬하려면 각각 해야함.

select employee_id, last_name, hire_date, salary*12 as 연봉,  department_id
from employees
where department_id  is not null
order by  department_id, salary*12;


select employee_id, last_name, hire_date, salary*12 as 연봉,  department_id
from employees
where department_id  is not null
order by  5,4 desc; -- position number, 5,4= colume 번호, 별칭도 가능
                           -- order by절은 항상 마지막에

select employee_id, last_name, hire_date, salary*12 as 연봉,  department_id
from employees
where salary*12 > 120000 --where절에는 별칭X
order by  5,4 desc;
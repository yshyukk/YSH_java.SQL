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
select substr('oracle database', 1,6) -- 소스에서 첫번째 데이터에서 6글자만 출력해라.
from dual;

select substr('oracle database', 1,6), substr('oracle database', 8,4)
from dual;

select substr('oracle database', 1,6), substr('oracle database', 8,4), substr('oracle database', 8)
from dual; --> 3번째 인수 생략하면 2번째 인수 뒤로 다 출력


select substr('oracle database', 1,6), substr('oracle database', 8,4), substr('oracle database', 8),
         substr('oracle database',-4,4)
from dual;

select employee_id, last_name, substr(last_name,1,3)
from employees
where substr(last_name,-1,1)='s';

select employee_id, last_name, substr(last_name,1,3)
from employees
where last_name like '%s';  --> 윗문장과 같음

--length
select employee_id, last_name, length(last_name)
from employees; -- 문자함수지만 (=인수가 문자) 결과는 숫자로

select length('oracle database'), length('오라클 데이터베이스')
from dual;

select lengthb('oracle database'), lengthb('오라클 데이터베이스')
from dual; -- lengthb : 데이터의 크기 비교

--INSRT
select employee_id, last_name, instr(last_name, 'a')
from employees; -- last_name의 데이터들안에서 a가 몇번째에 나오는지

select *
from employees
where instr(last_name, 'a')=0;

select *
from employees
where last_name not like '%a%'; --- 위와 같은 결과

--RPAD, LPAD //  L=데이터의 왼쪽을, R=데이터의 오른쪽을 ,PAD= (남는 공간을)채워라

select employee_id, RPAD(last_name,7,'*'), LPAD(salary, 15, '*') 
from employees;

--trim 접두어 접미어 잘라라!

SELECT TRIM('o' FROM 'oracle database') -- oracle database에서 o를 잘라라 (접두어나 접미어만 자를수 있음.)
FROM dual;

SELECT TRIM('w' FROM 'window'), --접두어 접미어 둘다
           TRIM(LEADING 'w' FROM 'window'), -- 접두어만
           TRIM(TRAILING 'w' FROM 'window') -- 접미어만
FROM dual;

SELECT employee_id, last_name,
           Concat('+82' , TRIM(LEADING '0' FROM phone_number))
From empolyees;

SELECT TRIM('0' from '000000123001122')
from dual;

SELECT TRIM('01' from ' 010101010101123001122 ')
from dual;  -- ''안에는 0 하나만 써야함.

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
where LOWER(last_name) ='king'; -- > 소문자로 입력해도 대문자 찾음

--------- <숫자 함수>

-- ROUND(인수, 자릿수)    자릿수 +값 : 소수점아래/ 생략: 정수로/ -값 : 10의자리로 ===>반올림
SELECT ROUND(45.923,2), ROUND(45.923), ROUND(45.923,-1)
FROM   DUAL;


-- TRUNC ===> 버림
SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923,-1)
FROM   DUAL;

-- MOD (나눌데이터, 나눌값)===> 나머지 구함
SELECT last_name, salary, MOD(salary, 5000)
FROM   employees
WHERE  job_id = 'SA_REP';

---------날짜 연산  RR/mm/dd

--sysdate ==인수X, 오늘 날짜 (서버가 있는 컴퓨터의 날짜)
SELECT sysdate 
FROM dual;

SELECT sysdate, sysdate+10 
FROM dual;

SELECT employee_id, last_name, hire_date, sysdate-hire_date AS 근무일수
FROM employees;

SELECT employee_id, last_name, hire_date, 
              TRUNC(sysdate-hire_date) AS 근무일수
FROM employees; --> 하루가 안되는 날짜는 무시하고 일수

SELECT last_name, ROUND((SYSDATE-hire_date)/7) AS WEEKS
FROM   employees
WHERE  department_id = 90;  --> 하루 반절이상 지나면 일수에 포함 


--날짜함수

--MONTHS_BETWEEN

SELECT employee_id, last_name, 
              MONTHS_BETWEEN(sysdate, hire_date)AS 근무기간
FROM employees;


SELECT employee_id, last_name, 
              TRUNC(MONTHS_BETWEEN(sysdate, hire_date))AS 근무기간
FROM employees;

--ADD_MONTHS, LAST_DAY
SELECT ADD_MONTHS(sysdate, 3), LAST_DAY(sysdate)
FROM dual;


--NEXT_DAY
SELECT NEXT_DAY(sysdate, '금요일'), NEXT_DAY(sysdate, '금'),
               NEXT_DAY(sysdate, 6) -- 일요일(1)~토~(7)
FROM dual;      

SELECT NEXT_DAY(sysdate, 'FRIDAY') 
FROM dual; --지역 언어가 적용됨.

--ROUND
    --year : 무조건 1월1일로 나옴, 올해의 절반이 지나갔으면 내년, 아니면 올해
    --month : 한달이 기준, 무조건 1일로 나옴.   
    --dd : 항상 0시로 나옴.
    --day : 1주일 ,무조건 일요일로 나옴. 수요일 12:00 전이면 지난 주 일요일, 후면 이번 주 일요일 

SELECT sysdate, ROUND(sysdate, 'year'), ROUND(sysdate, 'month'), 
              ROUND(sysdate, 'dd'), ROUND(sysdate, 'day')
FROM dual;       

--TRUNC : 시간을 반올림하지 않고 버리기 때문에 무조건 지난 
SELECT sysdate, TRUNC(sysdate, 'year'), TRUNC(sysdate, 'month'), 
       TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'day')
FROM dual;

--Q. 사원테이블의 입사일 (hire_date)을 이용하여 사원의 입사 후 첫 급여일과 업무검토일을 구하시오.
--  첫 급여일 : 입사한 다음달 5일
-- 업무 검토일 : 입사 후 3개월 후 처음 도래하는 금요일 입니다.

select employee_id, last_name, hire_date,
         LAST_DAY(hire_date)+5 "첫 급여일",
         NEXT_DAY(ADD_MONTHS (hire_date,3), '금요일') "검토일"
From employees;


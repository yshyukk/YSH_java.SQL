--날짜데이터에 TO_CHAR 함수 사용
--TO_CHAR로 바꾸면 결과는 문자!!!

SELECT employee_id, last_name, hire_date
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'dd-mm-yyyy') --> mm대신 month를 입력하면 '~월'로
FROM employees; -->> 출력되는 날짜는 문자 (날짜X)

SELECT employee_id, last_name, 
       TO_CHAR(hire_date, 'yyyy-mm-dd day') AS hire_date,
       TO_CHAR(hire_date, 'q') AS 분기,
       TO_CHAR(hire_date, 'w')||'주차' AS 주수
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd hh24:mi:ss')
FROM employees;

--날짜 연산에 응용

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+3/24,'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss')
FROM dual;

select employee_id, last_name, TO_CHAR(hire_date,'yyyy/mm/dd/ hh24mi:ss') 입사일
         FROM employees;
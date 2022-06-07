-- 숫자, 날짜 <--> 문자 : 변환함수

--TO_CHAR(날짜, 'format')
    --format
        -- 연도 : yyyy or yy/ rrrr or rr
        --월 : month/ mon(약어)/ mm(숫자)
        --일 : dd(1~31)/ d(요일 : 1~7사이 숫자)
        --요일 : day/ dy(약어)
        --시 : hh/ hh24
        --분 : mi
        --초 : ss
        --오전/오후 : pm/ am
        --주수 : w
        --분기 : q
        --

--TO_CHAR(숫자, 'format')
    --format
        -- 통화기호 : $(부동통화)/ L(지역통화)
        -- 자릿수 : 0, 9
        -- 구분기호 : ,(천단위) / .(소수점)
        
--날짜데이터에 TO_CHAR 함수 사용
SELECT employee_id, last_name, hire_date
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'dd-mm-yyyy')
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy') -->숫자로 나왔지만 문자
FROM employees;


SELECT employee_id, last_name, 
       TO_CHAR(hire_date, 'yyyy-mm-dd day') AS hire_date,
       TO_CHAR(hire_date, 'q') AS 분기,
       TO_CHAR(hire_date, 'w')||'주차' AS 주수
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd hh24:mi:ss') -- 시간데이터가 없는 정보는 알아서 0시0분0초로
FROM employees;

--날짜 연산에 응용
SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+3/24,'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss')
FROM dual;

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh:mi:ss am') -- AM이든 PM이든 상관 없음.
FROM dual;

--숫자데이터에 TO_CHAR 사용하기
SELECT employee_id, last_name, salary, 
               TO_CHAR(salary, '$999,999')--> 여기서 9는 숫자가 아니라 자릿수를 표현 (자릿수가 부족하면 ###으로 표현됨)
FROM employees;

SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, '$999,999.99'), 
       TO_CHAR(salary, '$099,999.99')--> 0을 넣어서 앞에 빈자리를 채워줌.
FROM employees;

SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, 'L999,999')
FROM employees;

ALTER SESSION SET nls_territory=germany;--> 세션(창)을 바꾸는 명령어  ,

SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, 'L999,999')
FROM employees;

ALTER SESSION SET nls_territory=korea;

SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, 'L999,999')
FROM employees;

--TO_DATE 함수('문자', 'format') : 컴퓨터가 날짜로 인식할 수 있도록 해주는 "이거 날짜야"

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > '12/31/1999';

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('31/12/1999', 'dd/mm/yyyy');

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('31/12/99', 'dd/mm/yy');

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('31/12/99', 'dd/mm/rr');

--TO_NUMBER 함수('문자', 'format')

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > $8,000; --> 문잔데 왜 ''없지?

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > '$8,000'; -- 숫자 > 문자라서 오류

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > TO_NUMBER('$8,000','$9,999');

--함수중첩

SELECT last_name,
              UPPER(CONCAT(SUBSTR (LAST_NAME, 1, 8), '_US'))
FROM   employees
WHERE  department_id = 60;

--일반함수 NVL : null값을 출력하는동안 다른 값으로 치환

SELECT employee_id, last_name, salary, commission_pct
FROM employees;

SELECT employee_id, last_name, salary, NVL(commission_pct, 0)
FROM employees;

SELECT employee_id, last_name, salary+salary*commission_pct as monthly_sal
FROM employees;

SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal
FROM employees;

--일반함수 NVL2(null값있는 coulmn, null이 있으면 출력값, null이 없으면 출력값)

SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal,
              NVL2(commission_pct, 'Y', 'N') AS comm_get
FROM employees;

SELECT last_name,  salary, commission_pct,
              NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM   employees 
WHERE department_id IN (50, 80);

--일반함수 NULL IF

SELECT employee_id, last_name, 
               salary+salary*NVL(commission_pct,0) as monthly_sal,
               NVL2(commission_pct, 'Y', 'N') AS comm_get,
               NULLIF(salary,  salary+salary*NVL(commission_pct,0)) AS result
FROM employees;

SELECT first_name, LENGTH(first_name) "expr1", 
              last_name,  LENGTH(last_name)  "expr2",
             NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM   employees;

--일반함수 COALESCE () : 인수값이 정해져있지 않음. 처음으로 null이 아닌 값을 출력 (행방향으로)

SELECT employee_id, commission_pct, manager_id,
              COALESCE(commission_pct, manager_id, 1234) AS result
FROM employees;  

SELECT last_name, employee_id, -- 자주씀
              COALESCE(TO_CHAR(commission_pct),TO_CHAR(manager_id), 'No commission and no manager') 
FROM employees;

--CASE 구문 사용     
SELECT last_name, job_id, salary,
              CASE job_id WHEN 'IT_PROG'  THEN  1.10*salary
                                    WHEN 'ST_CLERK' THEN  1.15*salary
                                    WHEN 'SA_REP'   THEN  1.20*salary
                                    ELSE      salary END     "REVISED_SALARY"
FROM   employees;

SELECT last_name, job_id, salary, --자바의 IF문
              CASE  WHEN job_id = 'IT_PROG'  THEN  1.10*salary
                          WHEN job_id = 'ST_CLERK' THEN  1.15*salary
                          WHEN job_id ='SA_REP'   THEN  1.20*salary
                          ELSE      salary END     "REVISED_SALARY" --<-:REVISED_SALARY : 별칭
FROM   employees;

SELECT employee_id, last_name, salary,
              CASE WHEN salary < 5000 THEN 'L'
                         WHEN salary BETWEEN 5000 AND 9000 THEN 'M'
                         ELSE 'H' END AS salary_grade
FROM employees;       

--NVL2 함수 결과를 CASE 문으로 대체 

SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal,
              CASE WHEN commission_pct IS NOT NULL THEN 'Y'
                         ELSE 'N' END AS comm_get
FROM employees;

--DECODE 함수 (오라클 전용) , 사용잘 안함. 대신 case를 사용 

SELECT last_name, job_id, salary,
             DECODE(job_id, 'IT_PROG',  1.10*salary,
                                          'ST_CLERK', 1.15*salary,
                                          'SA_REP',   1.20*salary,
                                                                        salary)  AS  REVISED_SALARY
FROM   employees;

SELECT last_name, salary,
               DECODE (TRUNC(salary/2000, 0),
                         0, 0.00,
                         1, 0.09,
                         2, 0.20,
                         3, 0.30,
                         4, 0.40,
                         5, 0.42,
                         6, 0.44,
                            0.45) TAX_RATE
FROM   employees
WHERE  department_id = 80;        
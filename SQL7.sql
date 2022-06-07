SELECT salary            --salary 열을 선택                   
FROM employees      --emplyees 테이블에서          
WHERE last_name = 'Grant';  -- last_name이 Grant인 데이터

SELECT *                --모든 컬럼에서
FROM employees     -- employees 테이블 중
WHERE salary > 7000;    --salary가 7000 이상인 데이터

-- 서브쿼리
    --GROUP BY절에서는 사용 X
SELECT *
FROM employees
WHERE salary > (SELECT salary          		--> 이 서브쿼리의 결과값 = 7000
                        FROM employees
                        WHERE last_name = 'Grant')
AND hire_date < (SELECT hire_date		-- GRANT보다 먼저 입사하고 GRANT보다 월급 많이 받는 사람.
                         FROM employees		--  date는 과거일수록 작아짐. 	
                         WHERE last_name='Grant');
                        
--Subquery의 기본 사용
SELECT salary 
FROM employees
WHERE last_name = 'Abel';

SELECT *
FROM employees
WHERE salary > 11000;

SELECT *
FROM employees
WHERE salary > (SELECT salary 
                             FROM employees
                            WHERE last_name = 'Abel');
                            
--단일행 서브쿼리(Single Row Subquery) : 서브쿼리만 따로 실행했는데 하나만 나오면
    -- 메인쿼리와 서브행쿼리 사이에 비교연산자를 사용하기 위해 = 비교연산자는 메인쿼리 > 단일행 쿼리에서만 사용 가능
SELECT last_name, job_id, salary
FROM   employees    --Matos와 job_id가 같고 salary가 같은 직원 찾기.
WHERE  job_id =  
                             (SELECT job_id     --Job_id 하나만 나오니까 단일행 쿼리
                              FROM   employees
                              WHERE  last_name = 'Matos')
AND    salary >
                             (SELECT salary -- salary 하나만 나오니까 단일행 쿼리
                              FROM   employees
                              WHERE  last_name = 'Matos');

SELECT MAX(salary) -- salary가 가장 많은 사람
FROM employees;

SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees);
                              
 --HAVING절 : GROUP BY절 없이 사용 X, GROUP을 선택하는 기능.
 --20번 부서보다 인원이 많은 부서 찾기.
SELECT   department_id, COUNT(*)
FROM     employees
GROUP BY department_id
HAVING  COUNT(*) > (SELECT COUNT(*)    
                                         FROM   employees
                                         WHERE  department_id = 20);      
                                        
-- 60번의 부서에서 가장 급여가 많은 사람과 동일한 급여를 받는 사람                                         
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                             WHERE department_id = 60);
                            
--다중 행 서브쿼리(Multiple Row Subquery)    

SELECT MAX(salary) 
FROM employees
GROUP BY department_id;

-- `=`을 사용했기때문에 단일행 쿼리가 나온다고 기대했지만 서브쿼리가 다중행이기 때문에 오류남.
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                              GROUP BY department_id);    

--    단일행              다중행
--      =           ->      IN
--      <>         ->       NOT IN
--        >      ---
--        >=    ---       +     ANY
--        <      ---        +    ALL
--        <=   ----



-- '='대신 IN을 사용.
SELECT last_name, job_id, salary
FROM   employees
WHERE salary IN (SELECT MAX(salary) 
                               FROM employees
                              GROUP BY department_id);  

SELECT salary 
FROM employees
WHERE department_id = 60;       

SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary 
                              FROM employees
                             WHERE department_id = 60)
AND department_id <> 60;      

-- 60번보다 큰 아무거나
--  AND department_id <> 60;  하지않으면 60번도 검색하니까!
-- ANY는 or 느낌
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ANY (SELECT salary 
                                      FROM employees
                                      WHERE department_id = 60)
AND department_id <> 60; 

SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ALL (SELECT salary 
                                    FROM employees
                                    WHERE department_id = 60)
AND department_id <> 60;


--Subquery 사용 시 주의사항
--Sub쿼리가 아무것도 반환하지 않으면 main쿼리도 아무것도 반환하지 않음.
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary
                              FROM employees
                              WHERE last_name = 'Mark');

--부하직원을 가진 매니저 찾기
SELECT employee_id, last_name
FROM employees 
WHERE employee_id IN (SELECT manager_id
                                           FROM employees);
-- 부하직원이 없는 매니저 찾기
 -- ()안은 OR --> OR 을 다시 NOT하므로 결과적으로 AND 
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees);    
                                              
-- IN은 =을 압축시켜놓은 것. NULL과 같은 값을 가진 것은 없기때문에 NULL은 = 연산자 사용하면 반환하는게 없음.                                                  
SELECT *
FROM employees
WHERE manager_id IN (100,101,NULL);

--  WHERE manager_id IS NOT NULL을 추가해 NULL값이 아닌 조건을 추가해야함.
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees
                                                     WHERE manager_id IS NOT NULL);  

--DESC는 테이블정보
DESC employees;

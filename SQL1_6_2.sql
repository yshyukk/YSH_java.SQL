-- 정규화? 테이블 쪼개기??
-- 정규화 전 테이블로 보기위해 사용 : JOIN


--NATURAL JOIN : 니가 알아서 JOIN해
    -- 두 테이블의 열 이름까지 같아야 가능.
SELECT * 
FROM departments;

SELECT * 
FROM locations;

SELECT department_id, department_name, location_id, city
FROM departments NATURAL JOIN locations;

SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;

--USING 절을 사용하는 JOIN (하나만 JOIN, 컬럼명이 같을 때)
    -- 컬럼명이 다를때는 사용X
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments -- 컬럼명이 같아야 가능
USING (department_id); -- (JOIN할때 사용되는 컬럼)

SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id);

--ON절을 사용하는 JOIN (데이터는 같지만 컬럼명이 다를 때)

SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);  -- Table명.컬럼 

SELECT employee_id, last_name, employees.department_id, department_name -- select에서도 어느 테이블인지 써줘야함.
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);  

--테이블 이름 별칭 사용

SELECT employees.employee_id, employees.last_name, 
               employees.department_id, departments.department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);


--(가장 흔한 JOIN문장 , 별칭사용)
SELECT e.employee_id, e.last_name, 
       e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

--WHERE 절 추가

SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.salary > 9000;

SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND e.salary > 9000;

--INNER JOIN과 OUTER JOIN
    --Inner 행 : JOIN의 결과로 나온 행
    --Outer 행 : JOIN의 결과에 나오지 않은 행
    --Outer  JOIN : 결과에 나온것까지 같이 JOIN, inner행에 Outer행을 추가하는 느낌
    
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);

--USING절에 OUTER 조인하기

SELECT employee_id, last_name, department_id, department_name
FROM employees LEFT OUTER JOIN departments
USING (department_id);

SELECT employee_id, last_name, department_id, department_name
FROM employees LEFT JOIN departments    -- ON절만 할 수 있는건 아니다.
USING (department_id); -- (JOIN할때 사용되는 컬럼)

--SELF JOIN : FROM절에 같은 테이블 2번
    --table별칭을 필수로
    
SELECT employee_id, last_name,manager_id
FROM employees;
    
SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e JOIN employees m 
ON (e.manager_id = m.employee_id);

SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e LEFT OUTER JOIN employees m
ON (e.manager_id = m.employee_id);

--NON-EQUI JOIN
SELECT * 
FROM job_grades;

SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

--3Way JOIN

SELECT e.employee_id, e.last_name, d.department_id, l.cityㅁ --join하는 열이 꼭 SELECT절에 있어야 하는 것은 아님.
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);

SELECT e.employee_id, e.last_name, d.department_id, l.city
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);

--Cartesian Products
SELECT employee_id, city
FROM employees NATURAL JOIN locations;

SELECT employee_id, department_name
FROM employees CROSS JOIN departments;

--GROUP함수와 JOIN 응용

SELECT   d.department_name, MIN(e.salary), 
                MAX(e.salary),TRUNC(AVG(e.salary))
FROM     employees e JOIN departments d
ON       (e.department_id = d.department_id)
GROUP BY d.department_name;


-- 문법
       -- NATURAL JOIN
       -- JOIN ~ USING
       -- JOIN ~ ON
       -- CROSS JOIN
       
-- JOIN 결과에 아우터행을 포함할지 여부
    --INNER JOIN : 일반적인 JOIN
    --OUNTER JOIN (LEFT/RIGHT/FULL)

--TABLE 수
    --1개 : SELF JOIN
    --3개 : 3 WAY JOIN
    
-- 연산자
    --EQUI JOIN(=)
    --NON EQUI JOIN(ex : BETWEEN)
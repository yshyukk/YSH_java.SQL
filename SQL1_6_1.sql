--JOIN이란??
--정규화 : 중복제거 등을 위해 테이블을 여러개로 나눔
--역정규화 : 정규화의 결과로 나뉜 테이블들을 합침

SELECT employee_id, last_name, salary, department_id, department_name
FROM employees JOIN departments
USING (department_id); --두 테이블 JOIN할때 부서번호를 이용해라 (적어도 한 column은 같은게 있어야됨.)

--JOIN(문법)
    --NATURAL JOIN
    --JOIN~USING
    --JOIN~ON
    --[LEFT | RINGHT | FULL] OUTER JOIN
    

--NATURAL JOIN
SELECT * 
FROM departments;

SELECT * 
FROM locations;

SELECT department_id, department_name, location_id, city
FROM departments NATURAL JOIN locations;    

SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;    --사원과 부서는 NATURAL JOIN 불가
                                                                        -- 두테이블의 같은 컬럼이 1개일때 사용 / 컬럼명까지 같을 때 가능.

--USING 절을 사용하는 JOIN
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);

SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id);

--ON절을 사용하는 JOIN : 컬럼명이 다른 테이블을 JOIN할때
SELECT employee_id, last_name, department_id, department_name   --department_id 이건 누구껀지 몰라서 오류! 아래처럼 바꿔야함.
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);

SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id); -- 컬럼명이 다른 테이블을 JOIN할때 두 테이블이 같다.


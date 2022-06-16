--TRUNCATE TABLE 테이블명 -->> 행을 다 지우고 테이블만 남는다. 다시하고싶을때 
--아래 다시 실행하면 초기화됨.
--@c:\db_test\sql_labs\cre_minstab.sql 
--UPDATE employees
--SET salary = 10500
--WHERE employee_id = 206;
--COMMIT;
--SELECT * FROM tab;

--Subquery의 다양한 활용법
SELECT l.location_id, l.city, l.country_id 
                        FROM locations l JOIN countries c
                       ON (l.country_id = c.country_id)
                       JOIN regions USING (region_id)
                       WHERE region_name ='Europe';
                       
SELECT department_name, city
FROM departments
NATURAL JOIN (SELECT l.location_id, l.city, l.country_id 
                        FROM locations l JOIN countries c
                       ON (l.country_id = c.country_id)
                       JOIN regions USING (region_id)
                       WHERE region_name ='Europe');
                       
INSERT INTO (SELECT l.location_id, l.city, l.country_id 
                        FROM locations l JOIN countries c
                       ON (l.country_id = c.country_id)
                       JOIN regions USING (region_id)
                       WHERE region_name ='Europe')
VALUES(3300, 'Cradiff', 'UK');

SELECT * FROM locations;

--명시적 DEFAULT 값 기능
DROP TABLE dept3 PURGE;

CREATE TABLE dept3
AS
SELECT * FROM departments;

--DEPT3 테이블의 manager_id 열에 기본값정의
ALTER TABLE dept3
MODIFY manager_id DEFAULT '9999';

SELECT * FROM dept3;

--DML 작업시 DEFAULT 값 사용하기

INSERT INTO dept3(department_id, department_name, manager_id)
VALUES(300, 'Engneering', DEFAULT);

UPDATE dept3
SET manager_id = DEFAULT
WHERE department_id = 10;

SELECT * FROM dept3;

COMMIT;

--Subquery를 사용한 INSERT 복습
DROP TABLE sales_reps PURGE;

CREATE TABLE sales_reps
AS
SELECT employee_id, last_name, salary, commission_pct
FROM employees 
WHERE 1=2;

INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

--Unconditional Insert Test
    --서브쿼리로 사용할 내용
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;

    
INSERT  ALL
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
INTO mgr_history VALUES(EMPID,MGR,SAL)
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;

SELECT * FROM sal_history;

SELECT * FROM mgr_history;

ROLLBACK;

--조건 ALL INSERT : when절이 여러개 있어도 만족하면 다 넣어라.

INSERT ALL
WHEN SAL > 10000 THEN
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
WHEN MGR > 200   THEN 
INTO mgr_history VALUES(EMPID,MGR,SAL)  
SELECT employee_id EMPID,hire_date HIREDATE,  
           salary SAL, manager_id MGR 
FROM   employees
WHERE  employee_id > 200;

SELECT * FROM sal_history;

SELECT * FROM mgr_history;

COMMIT;

--조건 FIRST INSERT
    --첫번째 when절을 만족하는 행은 첫번째 테이블에만 들어간다.   
    --두번째 조건부터는 INSERT ALL과 똑같이 작동
    --ELSE INTO :아무것도 만족하지 않으면 hiredate에 넣어라.
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;

INSERT FIRST   
WHEN SAL  > 25000  THEN    
INTO special_sal VALUES(DEPTID, SAL) 
WHEN HIREDATE like ('10%') THEN    
INTO hiredate_history_10 VALUES(DEPTID,HIREDATE)  
WHEN HIREDATE like ('09%') THEN
INTO hiredate_history_09 VALUES(DEPTID, HIREDATE)
ELSE  INTO hiredate_history VALUES(DEPTID, HIREDATE)
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;

SELECT * FROM special_sal;

SELECT * FROM hiredate_history_10;

SELECT * FROM hiredate_history_09;

SELECT * FROM hiredate_history;

COMMIT;

--피벗 INSERT
    -- 정규화가 잘못된 테이블임.
DESC sales_source_data

SELECT * FROM sales_source_data;

--피벗구조의 새로운 테이블 생성
    -- 피벗 : 가로, 세로가 바뀜.
CREATE TABLE sales_data
(sales_no NUMBER(8),
employee_id NUMBER(6),
WEEK_ID	NUMBER(2),
SALES	NUMBER(8,2));

SELECT * FROM sales_data;

--피벗 INSERT 실행하기
    -- 데이터가 계속 중복돼서 임의로 수를 지정해서 기본키를 설정해줘야함. ( 기본키는 무조건 있어야 하니까)
    --기본키를 설정하기 위해 일단 1을 넣어줌.
    
INSERT ALL
INTO sales_data VALUES (1, employee_id,week_id,sales_MON)  
INTO sales_data VALUES (1, employee_id,week_id,sales_TUE)
INTO sales_data VALUES (1, employee_id,week_id,sales_WED)
INTO sales_data VALUES (1, employee_id,week_id,sales_THUR)
INTO sales_data VALUES (1, employee_id,week_id, sales_FRI)
SELECT EMPLOYEE_ID, week_id, sales_MON, sales_TUE,
       sales_WED, sales_THUR,sales_FRI 
FROM sales_source_data;

SELECT * 
FROM sales_data;

--시퀀스생성 및 sales 번호(sales_no) 변경
    --시퀀스를 이용하여 위에서 설정한 1값으로 기본키를 설정
CREATE SEQUENCE sales_data_seq 
START WITH 101
INCREMENT BY 1
NOCACHE
NOCYCLE;

UPDATE sales_data
SET sales_no = sales_data_seq.nextval;

commit;

SELECT * FROM sales_data;

--정규화가 완료된 테이블 활용
SELECT employee_id, SUM(sales) FROM sales_data
WHERE week_id=6
GROUP BY employee_id

ORDER by 1;

COMMIT;

--MERGE 
	-- 중복되는게 없으면 INSERT
	-- 중복되는 것들은 UPDATE

--MERGE 문 테스트
--실습을 위한 emp13 테이블 생성
@c:\db_test\sql_labs\cre_emp13.sql 
 --정보확인(4명의 사원, 200번 부서, commission_pct가 모두 0.4)
SELECT * FROM emp13;

SELECT * FROM employees;

SELECT employee_id, commission_pct, department_id
FROM employees
WHERE employee_id IN (200,149,174, 176);

--MERGE 문 실행
    --INSERT VALUES : table을 한번만 읽어서 여러가지를 수행(<->대체 : IF문)
MERGE INTO emp13 c
     USING employees e
     ON (c.employee_id = e.employee_id)
   WHEN MATCHED THEN
     UPDATE SET
       c.last_name      = e.last_name,
       c.job_id         = e.job_id,
       c.salary         = e.salary,
       c.department_id  = e.department_id
      DELETE WHERE (e.commission_pct IS NULL) --employees에서 commission_pct가 null인 행은 제외됨
   WHEN NOT MATCHED THEN
     INSERT VALUES(e.employee_id, e.last_name,e.job_id,
          e.salary, e.commission_pct, e.department_id);

COMMIT;

SELECT * FROM emp13;

--Flashback 기술 TEST
--실습 전 Flashback Transaction Query를 위한 환경설정
--Run SQL CommandLine 실행
--관리자 접속
alter database add supplemental log data;

alter database add supplemental log data (primary key) columns;

grant execute on dbms_flashback to hr;

grant select any transaction to hr;

--Flashback: 빠르게 되돌린다.
--Flashback의 기능 중 commit한 것을 되돌리는 기능
--Flashback Query Test
            --------commit 전 : rollback-----
--DML   |                                          |----> Undo data
            --------commit 후 : flashback---
-- flashback query                 : undo data 제공받는 기능 ???
-- flashback version query      : undo data 제공받는 기능, ???
-- flashback transaction query : undo data 제공받는 기능, 실행할 수 있는 SQL을 알려줌
-- flashback Table                  : 실제 falshback, 되돌리는 기능

--Flashback Query Test
SELECT salary FROM employees
WHERE employee_id = 178;

UPDATE employees
SET salary = 12000

WHERE employee_id = 178;

COMMIT;

SELECT salary FROM employees
WHERE employee_id = 178;

--TIMESTAMP sysdate-5/(24*60) = 5분전 값을 보겠다.
SELECT salary FROM employees
AS OF  TIMESTAMP sysdate-5/(24*60)
WHERE employee_id = 178;

UPDATE employees
SET salary = (SELECT salary FROM employees
                  AS OF  TIMESTAMP sysdate-5/(24*60)
                  WHERE employee_id = 178)
WHERE employee_id = 178;

SELECT salary FROM employees
WHERE employee_id = 178;

COMMIT;

--Flashback Versions Query Test

UPDATE employees
SET salary = 10000
WHERE employee_id = 178;

COMMIT;

SELECT salary FROM employees
WHERE employee_id = 178;

--versions BETWEEN timestamp minvalue AND maxvalue : timestamp가 제일 최근것과 제일 오래된 것 모두 보겠다.
SELECT versions_starttime, versions_endtime, salary, versions_xid
FROM employees
versions BETWEEN timestamp minvalue AND maxvalue
WHERE employee_id = 178;

--Flashback Transaction Query
--Flashback Versions Query 결과의 급여 12000의 versions_xid 값 복사
--예시 0A001B004C020000
SELECT undo_sql FROM flashback_transaction_query
WHERE xid = '01001000B0010000';
--조회결과의 undo_sql 문장을 복사에서 실행 후 복원된 값 확인
--예시
update "HR"."EMPLOYEES" set "SALARY" = '12000' where ROWID = 'AAAE5oAAEAAAADMABO';
SELECT salary FROM employees
WHERE employee_id = 178;

COMMIT;



--TRUNCATE TABLE ���̺�� -->> ���� �� ����� ���̺� ���´�. �ٽ��ϰ������ 
--�Ʒ� �ٽ� �����ϸ� �ʱ�ȭ��.
--@c:\db_test\sql_labs\cre_minstab.sql 
--UPDATE employees
--SET salary = 10500
--WHERE employee_id = 206;
--COMMIT;
--SELECT * FROM tab;

--Subquery�� �پ��� Ȱ���
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

--����� DEFAULT �� ���
DROP TABLE dept3 PURGE;

CREATE TABLE dept3
AS
SELECT * FROM departments;

--DEPT3 ���̺��� manager_id ���� �⺻������
ALTER TABLE dept3
MODIFY manager_id DEFAULT '9999';

SELECT * FROM dept3;

--DML �۾��� DEFAULT �� ����ϱ�

INSERT INTO dept3(department_id, department_name, manager_id)
VALUES(300, 'Engneering', DEFAULT);

UPDATE dept3
SET manager_id = DEFAULT
WHERE department_id = 10;

SELECT * FROM dept3;

COMMIT;

--Subquery�� ����� INSERT ����
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
    --���������� ����� ����
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

--���� ALL INSERT : when���� ������ �־ �����ϸ� �� �־��.

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

--���� FIRST INSERT
    --ù��° when���� �����ϴ� ���� ù��° ���̺��� ����.   
    --�ι�° ���Ǻ��ʹ� INSERT ALL�� �Ȱ��� �۵�
    --ELSE INTO :�ƹ��͵� �������� ������ hiredate�� �־��.
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

--�ǹ� INSERT
    -- ����ȭ�� �߸��� ���̺���.
DESC sales_source_data

SELECT * FROM sales_source_data;

--�ǹ������� ���ο� ���̺� ����
    -- �ǹ� : ����, ���ΰ� �ٲ�.
CREATE TABLE sales_data
(sales_no NUMBER(8),
employee_id NUMBER(6),
WEEK_ID	NUMBER(2),
SALES	NUMBER(8,2));

SELECT * FROM sales_data;

--�ǹ� INSERT �����ϱ�
    -- �����Ͱ� ��� �ߺ��ż� ���Ƿ� ���� �����ؼ� �⺻Ű�� �����������. ( �⺻Ű�� ������ �־�� �ϴϱ�)
    --�⺻Ű�� �����ϱ� ���� �ϴ� 1�� �־���.
    
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

--���������� �� sales ��ȣ(sales_no) ����
    --�������� �̿��Ͽ� ������ ������ 1������ �⺻Ű�� ����
CREATE SEQUENCE sales_data_seq 
START WITH 101
INCREMENT BY 1
NOCACHE
NOCYCLE;

UPDATE sales_data
SET sales_no = sales_data_seq.nextval;

commit;

SELECT * FROM sales_data;

--����ȭ�� �Ϸ�� ���̺� Ȱ��
SELECT employee_id, SUM(sales) FROM sales_data
WHERE week_id=6
GROUP BY employee_id

ORDER by 1;

COMMIT;

--MERGE 
	-- �ߺ��Ǵ°� ������ INSERT
	-- �ߺ��Ǵ� �͵��� UPDATE

--MERGE �� �׽�Ʈ
--�ǽ��� ���� emp13 ���̺� ����
@c:\db_test\sql_labs\cre_emp13.sql 
 --����Ȯ��(4���� ���, 200�� �μ�, commission_pct�� ��� 0.4)
SELECT * FROM emp13;

SELECT * FROM employees;

SELECT employee_id, commission_pct, department_id
FROM employees
WHERE employee_id IN (200,149,174, 176);

--MERGE �� ����
    --INSERT VALUES : table�� �ѹ��� �о ���������� ����(<->��ü : IF��)
MERGE INTO emp13 c
     USING employees e
     ON (c.employee_id = e.employee_id)
   WHEN MATCHED THEN
     UPDATE SET
       c.last_name      = e.last_name,
       c.job_id         = e.job_id,
       c.salary         = e.salary,
       c.department_id  = e.department_id
      DELETE WHERE (e.commission_pct IS NULL) --employees���� commission_pct�� null�� ���� ���ܵ�
   WHEN NOT MATCHED THEN
     INSERT VALUES(e.employee_id, e.last_name,e.job_id,
          e.salary, e.commission_pct, e.department_id);

COMMIT;

SELECT * FROM emp13;

--Flashback ��� TEST
--�ǽ� �� Flashback Transaction Query�� ���� ȯ�漳��
--Run SQL CommandLine ����
--������ ����
alter database add supplemental log data;

alter database add supplemental log data (primary key) columns;

grant execute on dbms_flashback to hr;

grant select any transaction to hr;

--Flashback: ������ �ǵ�����.
--Flashback�� ��� �� commit�� ���� �ǵ����� ���
--Flashback Query Test
            --------commit �� : rollback-----
--DML   |                                          |----> Undo data
            --------commit �� : flashback---
-- flashback query                 : undo data �����޴� ��� ???
-- flashback version query      : undo data �����޴� ���, ???
-- flashback transaction query : undo data �����޴� ���, ������ �� �ִ� SQL�� �˷���
-- flashback Table                  : ���� falshback, �ǵ����� ���

--Flashback Query Test
SELECT salary FROM employees
WHERE employee_id = 178;

UPDATE employees
SET salary = 12000

WHERE employee_id = 178;

COMMIT;

SELECT salary FROM employees
WHERE employee_id = 178;

--TIMESTAMP sysdate-5/(24*60) = 5���� ���� ���ڴ�.
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

--versions BETWEEN timestamp minvalue AND maxvalue : timestamp�� ���� �ֱٰͰ� ���� ������ �� ��� ���ڴ�.
SELECT versions_starttime, versions_endtime, salary, versions_xid
FROM employees
versions BETWEEN timestamp minvalue AND maxvalue
WHERE employee_id = 178;

--Flashback Transaction Query
--Flashback Versions Query ����� �޿� 12000�� versions_xid �� ����
--���� 0A001B004C020000
SELECT undo_sql FROM flashback_transaction_query
WHERE xid = '01001000B0010000';
--��ȸ����� undo_sql ������ ���翡�� ���� �� ������ �� Ȯ��
--����
update "HR"."EMPLOYEES" set "SALARY" = '12000' where ROWID = 'AAAE5oAAEAAAADMABO';
SELECT salary FROM employees
WHERE employee_id = 178;

COMMIT;



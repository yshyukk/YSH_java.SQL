DROP TABLE orders_20 PURGE;

DROP TABLE prod_period PURGE;

DROP TABLE emp5 PURGE;

--DB SYSTEM �ð�����
    -- systimestamp : timezone���� ������(server������ ����)
SELECT sysdate, systimestamp FROM dual;

--CLIENT �����ð�����
SELECT current_date, current_timestamp, localtimestamp
FROM dual;

--������ ���� ���� �� �ð����� �ٽ� �ǽ�
--client�� ������ �ð� ����(�Ͽ��̷�)
ALTER SESSION SET time_zone='-10:00';

--DB�ִ� ������ �ð�����
SELECT sysdate, systimestamp FROM dual;

--client�� �ð� ����
SELECT current_date, current_timestamp, localtimestamp
FROM dual;

-- �ѱ��ð����� �ٽ� ����
ALTER SESSION SET time_zone='+09:00';

--TIMESTAMP ������Ÿ�� �ǽ�
    --TIMESTAMP TYPE : ���е��� ������ ������ �����غ��� -> developer���� �������ϰ� ���� ����
    -- ���� -> ȯ�漳�� -> �����ͺ��̽�->NLS -> �ð�������� �Ѵ� xx(���е�)����
CREATE TABLE orders_20
(ord_id number(8),
 ord_date date,
 payment_date timestamp,
 delivery_date timestamp with time zone,
 receipt_date timestamp with local time zone);

INSERT INTO orders_20
VALUES(12345678,  sysdate, sysdate+1/24, sysdate+1, sysdate+3);

COMMIT;

SELECT * FROM orders_20;

ALTER SESSION SET time_zone='-10:00';
--�Ͽ��̿� �ִ� ����� �ѱ������� ����
SELECT current_date, current_timestamp, localtimestamp
FROM dual;

SELECT * FROM orders_20;

ALTER SESSION SET time_zone='+01:00';

SELECT current_date, current_timestamp, localtimestamp
FROM dual;

SELECT * FROM orders_20;
ALTER SESSION SET time_zone='+09:00';
--SQL Developer���� TIMESTAMP WITH LOCAL TIME ZONE Ÿ�Ի�� �� TIME ZONE ���濡 ���� �����ذ��
--Ž���⿡�� ���� ������ �޸������� ���ϴ�.
--sqldeveloper/sqldeveloper/bin/sqldeveloper.conf
--���� ���� ������ �߰��մϴ�.
--AddVMOption -Duser.timezone=GMT-10
--���ο� SQL Developer�� �����ϰ� ����� Ȯ���մϴ�.

--date : yy/mm/dd

                        --timestamp : 
 --datetime type  --timestamp with time zone
                        --timestamp local time zone
SELECT sysdate+10, sysdate+10
FROM dual;

SELECT TO_CHAR(sysdate+10/24, 'yyyy/mm/dd/ hh24:mi:ss')
FROM dual;

SELECT ADD_MONTH(sysdate, 5) 
FROM dual;

SELECT ADD_MONTH(sysdate,60)
FROM dual;

--INTERVAL TYPE Test
CREATE TABLE prod_period
(p_id NUMBER(2), 
 exchange_period INTERVAL DAY TO SECOND,
 warrant_period INTERVAL YEAR TO MONTH);

--TABLE ���鶧 ()�ڸ��� �ڸ��� �Է��ϸ� ���� ����
DESC prod_period

-- DAY�� YEAR�� ���� ������ ������ �������� ��.
INSERT INTO prod_period
VALUES(1, INTERVAL '15' DAY, INTERVAL '3' YEAR);

INSERT INTO prod_period
VALUES(2, INTERVAL '7 12:30:00' DAY TO SECOND, INTERVAL '10-6' YEAR TO MONTH);

COMMIT;

SELECT * FROM prod_period;

--�ֹ��������� ��ȯ�������� �� ���������� ��ȸ(�����ϱ���)
SELECT ord_id, receipt_date, receipt_date+exchange_period, receipt_date+warrant_period
FROM orders_20 , prod_period 
WHERE p_id = 1;

SELECT ord_id, receipt_date, receipt_date+15, ADD_MONTHS(receipt_date,36)
FROM orders_20;

SELECT ord_id, receipt_date, receipt_date+exchange_period, receipt_date+warrant_period
FROM orders_20 , prod_period 
WHERE p_id = 2;

--�����Լ��� Ȱ��
--�ǽ��� ���� EMP5 ���̺� ���� 
    --sub query
        --TO_YMINTERVAL('��-��')
SELECT employee_id, last_name, hire_date+TO_YMINTERVAL('5-0') AS hire_date, department_id
FROM employees;

CREATE TABLE emp5
AS
SELECT employee_id, last_name, hire_date+TO_YMINTERVAL('5-0') AS hire_date, department_id
FROM employees;

SELECT * FROM emp5;

--�Ի��Ϸκ��� ����/��/ ����
    --EXTRACT(year from hire_date) : ��¥�κ��� ���� �����Ѵ�.
SELECT employee_id, last_name, EXTRACT(year from hire_date) 
FROM emp5;
SELECT employee_id, last_name, EXTRACT(month from hire_date) 
FROM emp5;
--day ����� ��¥ ��ȯ
SELECT employee_id, last_name, EXTRACT(day from hire_date) 
FROM emp5;
--��ȯ�Լ� ���� ��
SELECT employee_id, last_name, TO_CHAR(hire_date, 'YYYY') 
FROM emp5;
--��ȯ�Լ� ��뿡�� day�� ��ȯ �� ���� ��ȯ
SELECT employee_id, last_name, TO_CHAR(hire_date, 'day') 
FROM emp5;

--TZ_OFFSET �Լ��� ������ ��������
SELECT TZ_OFFSET('Asia/Seoul') FROM dual;

SELECT * FROM v$timezone_names
WHERE tzname LIKE '%Seoul%';

SELECT TZ_OFFSET('Asia/Seoul') FROM dual;

SELECT * FROM v$timezone_names
WHERE tzname LIKE '%Japan%';

SELECT TZ_OFFSET('Japan') FROM dual;

--EMP5�� hire_date ���� ������Ÿ���� timestamp Ÿ������ ����
    --timestamp(0)���� ()�ȿ� ���ڴ� �ʹؿ� ���� = ���е�
ALTER TABLE emp5
MODIFY hire_date timestamp(0);

DESC emp5;

SELECT * FROM emp5;

--FROM_TZ�Լ��� ����Ͽ� ��¥������ ���� timezone ǥ��
SELECT employee_id, last_name, FROM_TZ(hire_date, '+09:00') AS hire_date
FROM emp5;

--TIMESTAMP �������������� ��ȯ�Լ�

--TO_TIMESTAMP �Լ��� ����Ͽ� ���ڸ� timestamp Ÿ�� �����ͷ� ��ȯ
SELECT * FROM emp5
WHERE hire_date > TO_TIMESTAMP('01.01.2000 09:00:00','dd.mm.yyyy hh24:mi:ss');

--TO_YMINTERVAL �Լ�������� �ֹ��Ϸκ��� �����Ⱓ ���ϱ�
SELECT ord_id, ord_date, ord_date+TO_YMINTERVAL('3-0') 
FROM orders_20;

--TO_DSINTERVAL �Լ�������� �ֹ��Ϸκ��� �������ɽð� �� ��ȯ���ɱⰣ ���ϱ�
SELECT ord_id, TO_CHAR(ord_date,'yyyy/mm/dd hh24:mi:ss'), 
       TO_CHAR(ord_date+TO_DSINTERVAL('0 02:30:00'),'yyyy/mm/dd hh24:mi:ss') AS �������ɽð�,
       ord_date+TO_DSINTERVAL('10 00:00:00') AS ��ȯ���ɱⰣ
FROM orders_20; 
--TO_DSINTERVAL  ����� ���
SELECT ord_id, ord_date,ADD_MONTHS(ord_date, 36)
FROM orders_20;
SELECT ord_id, TO_CHAR(ord_date,'yyyy/mm/dd hh24:mi:ss'), 
       TO_CHAR(ord_date+150/(24*60),'yyyy/mm/dd hh24:mi:ss') AS �������ɽð�
FROM orders_20;  
--Clear Test
DROP TABLE orders_20 PURGE;
DROP TABLE prod_period PURGE;
DROP TABLE emp5 PURGE;
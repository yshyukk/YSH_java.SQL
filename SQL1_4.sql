--��¥�����Ϳ� TO_CHAR �Լ� ���
--TO_CHAR�� �ٲٸ� ����� ����!!!

SELECT employee_id, last_name, hire_date
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'dd-mm-yyyy') --> mm��� month�� �Է��ϸ� '~��'��
FROM employees; -->> ��µǴ� ��¥�� ���� (��¥X)

SELECT employee_id, last_name, 
       TO_CHAR(hire_date, 'yyyy-mm-dd day') AS hire_date,
       TO_CHAR(hire_date, 'q') AS �б�,
       TO_CHAR(hire_date, 'w')||'����' AS �ּ�
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd hh24:mi:ss')
FROM employees;

--��¥ ���꿡 ����

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+3/24,'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss')
FROM dual;

select employee_id, last_name, TO_CHAR(hire_date,'yyyy/mm/dd/ hh24mi:ss') �Ի���
         FROM employees;
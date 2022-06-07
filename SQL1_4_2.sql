-- ����, ��¥ <--> ���� : ��ȯ�Լ�

--TO_CHAR(��¥, 'format')
    --format
        -- ���� : yyyy or yy/ rrrr or rr
        --�� : month/ mon(���)/ mm(����)
        --�� : dd(1~31)/ d(���� : 1~7���� ����)
        --���� : day/ dy(���)
        --�� : hh/ hh24
        --�� : mi
        --�� : ss
        --����/���� : pm/ am
        --�ּ� : w
        --�б� : q
        --

--TO_CHAR(����, 'format')
    --format
        -- ��ȭ��ȣ : $(�ε���ȭ)/ L(������ȭ)
        -- �ڸ��� : 0, 9
        -- ���б�ȣ : ,(õ����) / .(�Ҽ���)
        
--��¥�����Ϳ� TO_CHAR �Լ� ���
SELECT employee_id, last_name, hire_date
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'dd-mm-yyyy')
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy') -->���ڷ� �������� ����
FROM employees;


SELECT employee_id, last_name, 
       TO_CHAR(hire_date, 'yyyy-mm-dd day') AS hire_date,
       TO_CHAR(hire_date, 'q') AS �б�,
       TO_CHAR(hire_date, 'w')||'����' AS �ּ�
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd hh24:mi:ss') -- �ð������Ͱ� ���� ������ �˾Ƽ� 0��0��0�ʷ�
FROM employees;

--��¥ ���꿡 ����
SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+3/24,'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss')
FROM dual;

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh:mi:ss am') -- AM�̵� PM�̵� ��� ����.
FROM dual;

--���ڵ����Ϳ� TO_CHAR ����ϱ�
SELECT employee_id, last_name, salary, 
               TO_CHAR(salary, '$999,999')--> ���⼭ 9�� ���ڰ� �ƴ϶� �ڸ����� ǥ�� (�ڸ����� �����ϸ� ###���� ǥ����)
FROM employees;

SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, '$999,999.99'), 
       TO_CHAR(salary, '$099,999.99')--> 0�� �־ �տ� ���ڸ��� ä����.
FROM employees;

SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, 'L999,999')
FROM employees;

ALTER SESSION SET nls_territory=germany;--> ����(â)�� �ٲٴ� ��ɾ�  ,

SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, 'L999,999')
FROM employees;

ALTER SESSION SET nls_territory=korea;

SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, 'L999,999')
FROM employees;

--TO_DATE �Լ�('����', 'format') : ��ǻ�Ͱ� ��¥�� �ν��� �� �ֵ��� ���ִ� "�̰� ��¥��"

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

--TO_NUMBER �Լ�('����', 'format')

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > $8,000; --> ���ܵ� �� ''����?

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > '$8,000'; -- ���� > ���ڶ� ����

SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > TO_NUMBER('$8,000','$9,999');

--�Լ���ø

SELECT last_name,
              UPPER(CONCAT(SUBSTR (LAST_NAME, 1, 8), '_US'))
FROM   employees
WHERE  department_id = 60;

--�Ϲ��Լ� NVL : null���� ����ϴµ��� �ٸ� ������ ġȯ

SELECT employee_id, last_name, salary, commission_pct
FROM employees;

SELECT employee_id, last_name, salary, NVL(commission_pct, 0)
FROM employees;

SELECT employee_id, last_name, salary+salary*commission_pct as monthly_sal
FROM employees;

SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal
FROM employees;

--�Ϲ��Լ� NVL2(null���ִ� coulmn, null�� ������ ��°�, null�� ������ ��°�)

SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal,
              NVL2(commission_pct, 'Y', 'N') AS comm_get
FROM employees;

SELECT last_name,  salary, commission_pct,
              NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM   employees 
WHERE department_id IN (50, 80);

--�Ϲ��Լ� NULL IF

SELECT employee_id, last_name, 
               salary+salary*NVL(commission_pct,0) as monthly_sal,
               NVL2(commission_pct, 'Y', 'N') AS comm_get,
               NULLIF(salary,  salary+salary*NVL(commission_pct,0)) AS result
FROM employees;

SELECT first_name, LENGTH(first_name) "expr1", 
              last_name,  LENGTH(last_name)  "expr2",
             NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM   employees;

--�Ϲ��Լ� COALESCE () : �μ����� ���������� ����. ó������ null�� �ƴ� ���� ��� (���������)

SELECT employee_id, commission_pct, manager_id,
              COALESCE(commission_pct, manager_id, 1234) AS result
FROM employees;  

SELECT last_name, employee_id, -- ���־�
              COALESCE(TO_CHAR(commission_pct),TO_CHAR(manager_id), 'No commission and no manager') 
FROM employees;

--CASE ���� ���     
SELECT last_name, job_id, salary,
              CASE job_id WHEN 'IT_PROG'  THEN  1.10*salary
                                    WHEN 'ST_CLERK' THEN  1.15*salary
                                    WHEN 'SA_REP'   THEN  1.20*salary
                                    ELSE      salary END     "REVISED_SALARY"
FROM   employees;

SELECT last_name, job_id, salary, --�ڹ��� IF��
              CASE  WHEN job_id = 'IT_PROG'  THEN  1.10*salary
                          WHEN job_id = 'ST_CLERK' THEN  1.15*salary
                          WHEN job_id ='SA_REP'   THEN  1.20*salary
                          ELSE      salary END     "REVISED_SALARY" --<-:REVISED_SALARY : ��Ī
FROM   employees;

SELECT employee_id, last_name, salary,
              CASE WHEN salary < 5000 THEN 'L'
                         WHEN salary BETWEEN 5000 AND 9000 THEN 'M'
                         ELSE 'H' END AS salary_grade
FROM employees;       

--NVL2 �Լ� ����� CASE ������ ��ü 

SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal,
              CASE WHEN commission_pct IS NOT NULL THEN 'Y'
                         ELSE 'N' END AS comm_get
FROM employees;

--DECODE �Լ� (����Ŭ ����) , ����� ����. ��� case�� ��� 

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
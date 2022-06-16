-- << DICTIONARY>>
--Metadata(Data dictionary) : DB���鶧 �ڵ�����
	-- Base Table -> Data Dcitionary view(=>����ڿ��� ����)
			
	--# Data Dcitionary view
		
	--	(��������)        (�׸�)	
	--	- DBA_		* 	DBA�� ����, DB��ü�� ���	
	--	- ALL_		*	�������ڰ� ���ٰ����� ~
	--	- USER_		*	�������ڰ� �����ϴ� ~
	
--	<Ex:> DBA_TABLES  : DB��ü�� �ִ� table
--	        ALL_ TABLES  : ���� ����ڰ� ���� ������ Table
--	        USER_TABLES : ���� ����� ������ table
		        	


-- ��밡 ������ �ִ� TABLE ��ȸ
    --����ڰ� ���� �ִ� table
SELECT COUNT (*) FROM user_tables;
    --all_tables :  �� �� �ִ� ���̺�
SELECT COUNT (*) FROM all_tables;
    --dba_tables : �����ڰ��� �ƴ϶� ��ȸX 
SELECT COUNT (*) FROM dba_tables;

CREATE TABLE testemp
as
SELECT * FROM employees;

DROP TABLE testemp purge;

--Creating Objects For Test
create table emp3_tab
as
select * from employees;

create index emp3_empid_ix on emp3_tab(employee_id);
create view emp3_list_vu
as
select employee_id, last_name, department_id
from emp3_tab
where department_id not in (10,90);

create synonym emp3  for emp3_list_vu;

create sequence emp3_seq
increment by 1 start with 250
nocache
nocycle;

--Dictionary�� ���� ����� ���� Object ���� ���� Ž���ϱ�
select view_name, text from user_views
where view_name like 'EMP3%';

select synonym_name, table_owner, table_name
from user_synonyms
where synonym_name = 'EMP3%';

select sequence_name, increment_by, max_value, cache_size
from user_sequences
where sequence_name like 'EMP3%';

select index_name, status from user_indexes
where index_name like 'EMP3%';

select object_name, object_type, status from user_objects
where object_name like 'EMP3%';

--Table ���� �� ������ü�� ���� �˾ƺ���
drop table emp3_tab;

select index_name, status from user_indexes
where index_name like 'EMP3%';

select object_name, object_type, status from user_objects
where object_name like 'EMP3%';

--Clear Test
drop view emp3_list_vu;

drop synonym emp3;

drop sequence emp3_seq;
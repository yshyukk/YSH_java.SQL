-- << DICTIONARY>>
--Metadata(Data dictionary) : DB만들때 자동생성
	-- Base Table -> Data Dcitionary view(=>사용자에게 제공)
			
	--# Data Dcitionary view
		
	--	(제공범위)        (항목)	
	--	- DBA_		* 	DBA만 접근, DB전체를 대상	
	--	- ALL_		*	현재사용자가 접근가능한 ~
	--	- USER_		*	현재사용자가 소유하는 ~
	
--	<Ex:> DBA_TABLES  : DB전체에 있는 table
--	        ALL_ TABLES  : 현재 사용자가 접근 가능한 Table
--	        USER_TABLES : 현재 사용자 소유의 table
		        	


-- 사용가 가지고 있는 TABLE 조회
    --사용자가 갖고 있는 table
SELECT COUNT (*) FROM user_tables;
    --all_tables :  쓸 수 있는 테이블
SELECT COUNT (*) FROM all_tables;
    --dba_tables : 관리자가가 아니라 조회X 
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

--Dictionary로 부터 사용자 소유 Object 관련 정보 탐색하기
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

--Table 삭제 후 연관객체의 상태 알아보기
drop table emp3_tab;

select index_name, status from user_indexes
where index_name like 'EMP3%';

select object_name, object_type, status from user_objects
where object_name like 'EMP3%';

--Clear Test
drop view emp3_list_vu;

drop synonym emp3;

drop sequence emp3_seq;
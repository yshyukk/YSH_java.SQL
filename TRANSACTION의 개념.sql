-- <<<TRNASACTION의 개념>>>

-- SESSION : 접속~접속해제
-- TRANSACTION : DML ~ COMMIT/ROLLBACK

-- 접속 (ID/Password) -------------------------< SESSION 시작 >

--SELECT... 

--DML (INSTERT / UPDATE/DELETE)----------<TRANSCATION 시작 >
--DML				   : 논리적으로 연관되어서 한꺼번에 처리해야 하는 DML의 묶음
--DML
--DML
--COMMIT/ROLLBACK -----------------------< TRANSCATION 종료 >

--DML-----------------------------------------<TRANSCATION 시작 >
--DML
--SELECTE  : TRANSACTION 실행중 SELECTE를 했다고해서 SESSION이 시작하는 건 아님 
--DML
--DML
--COMMIT/ROLLBACK -----------------------< TRANSCATION 종료 >

--접속해제 (Tool 종료)------------------------< SESSION 종료 >

--한 SESSION 내에서 여러 TRANSACTION 발생 가능.

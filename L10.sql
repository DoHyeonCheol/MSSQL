--SP_select_companyinfo라는 프로시저 만들기

use study
go
create procedure SP_select_companyinfo
as
begin

select*from companyinfo
end

--생성된 프로시저 SP_select_companyinfo를 실행하기

exec SP_select_companyinfo

--기업코드와 기간을 입력 받아 해당 기간 동안의 기업의 가격을 출력하는 프로시저 만들기
create proc SP_SELECT_STOCKPRICE @ID int, @StartDate Date, @EndDate Date
as
begin

select Date_, Close_
from StockPrice
where ID=@ID
and DATE_ between @StartDate and @EndDate
order by DATE_ DESC
end
go
exec SP_SELECT_STOCKPRICE 40853, '2020-10-01', '2020-10-13'

/*
코드 설명

create proc SP_SELECT_STOCKPRICE @ID int, @StartDate Date, @EndDate Date

-> 기업코드, 시작 날짜, 마지막 날짜를 의미

and DATE_ between @StartDate and @EndDate

-> 시작 날짜와 마지막 날짜 사이의 값으로 가져오라는 뜻
*/

--생성된 프로시저 삭제하기
drop procedure SP_select_companyinfo
drop procedure SP_SELECT_STOCKPRICE

--if문을 이용해 선언된 변수가 짝수인지 홀수인지 알려주는 코드 작성하기
DECLARE @I INT = 110
IF @I%2 = 0
BEGIN
PRINT N'짝수'
END
ELSE
BEGIN
PRINT N'홀수'
END

--while 문을 이용해 1에서 100까지의 값을 더하는 코드 작성하기
DECLARE @I INT = 1
DECLARE @ADDED BIGINT = 0
WHILE (@I <=100)
BEGIN
SET @ADDED = @ADDED + @I
SET @I = @I+1
END
PRINT @ADDED

/*
코드 설명
최초의 @I는 1임
@ADDED는 1 부터 100값이 더해진 결과가 저장될 변수
WHILE문 : @I값이 100보다 작은 경우 계속 실행한다는 뜻

즉, @I가 100이 넘어가기 전까지 WHILE안의 구문이 계속 실행되며 @I와 @ADDED를 갱신
@I가 101이 되는 순간 WHILE 구문을 빠져나와 그동안 @I 값이 더해져서 계속 갱신되었던 @ADDED의 최종 값 출력
*/


--while문에 contibue와 break를 넣어 코드를 작성하기
DECLARE @I INT = 1
DECLARE @ADDED BIGINT = 0
WHILE (@I <=100)
BEGIN
IF @I%9 = 0
BEGIN
PRINT CAST(@I AS VARCHAR) + N' : 9의 배수입니다.'
SET @I = @I + 1
CONTINUE
END
IF @ADDED >=3000
BEGIN
PRINT N'@ADDED가' + CAST(@ADDED AS VARCHAR) + N' 값이 되어 종료합니다.'
BREAK
END
SET @ADDED = @ADDED + @I
SET @I = @I +1
END

--테이블의 이름을 매개변수로 받아 해당 테이블의 데이터를 출력해주는 프로시저 작성하기
CREATE PROC SP_SELECT_TABLE_INFO @TableName Varchar(3000)         --> 입력변수 : 테이블명
AS  
BEGIN
   DECLARE @sqlQuery varchar(3000)
   SET @sqlQuery = 'SELECT*FROM ' + @TableName       --> 문자열 변수에 쿼리 저장

   EXEC(@sqlQuery)                                   --> 문자열로 된 쿼리 수행

END
GO

exec SP_SELECT_TABLE_INFO 'StockPrice'
exec SP_SELECT_TABLE_INFO 'Companyinfo'


/*

1. 저장 프로시저 (stored procedure)
 -SQL에서 제공하는 프로그래밍 기능
 -함수보다 폭넓은 동작 수행 -> 복잡한 비즈니스 로직을 넣을 수 있으며, 데이터 처리를 수행할 수도 있음

저장 프로시저를 만드는 방법
create procedure <procedure name>
@<parameters>
as
begin
<sql_query>      -> 개발자가 무엇을 입력하느냐에 따라 복잡할지 단순할지 달려 있음
end

-> DB - 프로그래밍 - 프로시저에 존재함

2. 매개변수가 있는 프로시저
  -프로시저도 함수와 같이 매개변수를 받아 처리해 외부로 결과를 내보낼 수 있음 -> 하지만, 괄호는 사용하지 않음

3. 프로시저의 수정 및 삭제

- 프로시저를 수정하는 방법
alter procedure<procedure name>
@<parameters>
as
begin
<sql_query>
end

- 프로시저를 삭제하는 방법
drop procedure<procedure name>

4. 제어문과 반복문

if문
조건을 만족할 때 실행하며 불만족 시 무시함

if else문
조건을 만족할 때 무시하며 불만족 시 실행함
 -> begin...end로 쿼리문들을 묶어줘야 하며, begin과 end 사이의 구문을 실행하는 것임
 -> 그렇지 않을 경우, 첫문장만 실행되거나 오류 반환

if<조건문>
  begin
    <sql_query1>
  end
else
  begin
    <sql_query2>
  end

--> if문 뒤의 조건이 true면 sql_query1을 실행하고, 아니면 sql_query2를 실행

while문
-SQL문을 조건이 만족하는 한 계쏙 반복 실행을 하는 구문
-while 구문과 엮인 SQL문은 지정된 조건이 만족되는 한 반복적으로 실행
-while 루프 내의 SQL문 실행을 break와 continue 키워드를 사용하여 제어

while<조건문>
begin
  <sql_query1>
  <sql_query2 | break | continue>
end

continue와 break는 주로 if문과 함께 사용
continue : 루프를 계속 진행하라는 의미로 아래 부분에 위치한 코드들을 수행하지 않고 바로 while 루프의 처음으로 돌아가도록 작동
break : 해당 루프를 빠져나가 종료


동적 SQL
코드를 문자열로 만든 다음 그 문자열을 실행시키는 방법
 ex) "select*from companyinfo"라는 문자열을 어떤 문자열 변수에 저장시킨 다음 그 문자열을 수행시키는 것

SELECT*FROM STUDY.CBO.COMPANYINFO
EXEC('SELECT*FROM STUDY.DBO.COMPANYINFO)  -> 두 코드는 서로 같은 결과값을 반환함

매개변수로 테이블 명을 받아 해당 테이블의 값을 출력하고 싶은 경우 사용함
기존 SQL 쿼리에 비해 다양한 동작을 수행할 수 있다는 장점이 있음

*/
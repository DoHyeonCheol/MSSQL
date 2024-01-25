--1. Scalar 함수

--f_plus 이름의 덧셈 함수 만들기
create function f_plus(      
@value1 int,                   --> 숫자 형태의 데이터를 갖는다는 의미
@value2 int                    --> f_plus에 두개의 값이 들어간다는 것을 의미
)
returns int                    
as
begin
declare @sum_value int                --> declare : 변수를 선언한다는 뜻 (declare @변수명<data type>)
set @sum_value = (@value1+@value2)    --> 변수에 값을 할당하려면 set문 활용
return @sum_value 
end

--f_plus 함수 이용하기
go
select dbo.f_plus(10, 20)

--stock price 테이블 살펴보기
use study
go
select*from StockPrice

--companyinfo 살펴보기
use study
go
select*from companyinfo

--f_return 함수 만들기 (f_return : 시작일, 종료일, 기업코드 입력 시 해당 날짜 사이의 수익률을 구해주는 함수)
  --> @뒤에 오는 매개변수 총 3개 (시작일 startdate / 종료일 enddate / 기업코드 ID)
  --> 각 뒤에는 데이터 형태를 나타내는 date, int 등이 있음

create function f_return(@startdate date, @enddate date, @ID int)
returns decimal(12, 10)
as
begin

declare @startprice numeric
declare @endprice numeric

set @startdate = (select min(date_) from stockprice where @ID = ID and date_ >= @startdate)  --1
set @enddate = (select max(date_) from stockprice where @ID = ID and date_ <= @enddate)      --2
set @startprice = (select close_ from stockprice where @ID = ID and date_ = @startdate)      --3
set @endprice = (select close_ from stockprice where @ID = ID and date_ = @enddate)          --4

return (@endprice / @startprice -1.0)
end

/*
위 코드 설명
returns decimal(12, 10)      -> 함수의 결과값을 소수점 이하 10번째 자리까지 보이는 설정
declare @startprice numeric  -> startprice 라는 변수를 숫자형 데이터로 선언한다는 뜻
set 1 : @startdate가 휴일인 경우 가격이 없으므로 가장 가까운 다음 거래일을 찾기 위한 코드
set 2 : @enddate에 가장 가까운 거래일을 찾도록 만든 코드
set 3,4 : close_가격을 가져와서 수익률을 계산
*/

--f_return 함수에 companyinfo에 존재하는 모든 종목 적용하기
select c.*
, dbo.f_return('2020-10-01', '2020-10-12', ID) as ret
from companyinfo c


--2. 테이블을 반환하는 함수 1

--f_info 함수 만들기
create function f_info(@id int)
returns table
as return
(
select R.FIN_NAME
, R.FIN_VAL
, R.FDATE
, R.FPRD
, A.Name
from companyinfo A
join IDMap I
on A.ID=I.ID
join Ratios R
on I.FIN_ID=R.FIN_ID
where A.ID=@ID
)
go
select*
from dbo.f_INFO(40853) 

/*
코드 설명
companyinfo = A / Ratios = R / IDMap = I

from companyinfo A
join IDMap I
on A.ID=I.ID
join Ratios R
on I.FIN_ID=R.FIN_ID

-> companyinfo A로 부터 IDMap I 와 Ratios R을 차례대로 조인
    - 먼저 A와 I를 조인하되, ID를 기준으로 조인
	- 그 후 I와 R을 조인, FIN_ID를 기준으로 함
	-> A와 I의 공통 key는 ID, I와 R의 공통 key는 FIN_ID이기 때문
	+ Ratios에는 기업의 재무관련 데이터가 존재하는데, ID가 아닌 FIN_ID가 기업코드로 작동
	+ IDMap을 중간 매개로 FIN_ID를 찾고 이를 한번 더 join을 걸어 재무 데이터를 가져옴

select R.FIN_NAME
, R.FIN_VAL
, R.FDATE
, R.FPRD
, A.Name

-> R로부터 각각 FIN_NAME, FIN_VAL, FDATE, FPRD를 A로부터 Name이라는 필드를 선택하라는 뜻 

where A.ID=@ID

-> select와 함께 나오는 구문으로 join 해놓은 테이블에서 특정 조건에 부합하는 데이터만 조회하고 싶을 때 사용
   A.ID에 대한 필드가 존재하는 데이터만 추출하라는 뜻
*/


--3. 테이블을 반환하는 함수 2

--f_info2 함수 만들기
create function f_info2(@ID int)
returns @return_table table
(
FIN_NAME varchar(300)
, FIN_VAL float
, FDATE Date
, FPRD int
, Name NVARCHAR(3000)
)
as
begin
insert into @return_table
select R.FIN_NAME
, R.FIN_VAL
, R.FDATE
, R.FPRD
, A.Name
from companyinfo A
join IDMap I
on A.ID=I.ID
join Ratios R
on I.FIN_ID=R.FIN_ID
where A.ID=@ID

return
end

go
select*from dbo.f_info2(40853)

/*
코드 설명

create function f_info2(@ID int)
returns @return_table table
(
FIN_NAME varchar(300)
, FIN_VAL float
, FDATE Date
, FPRD int
, Name NVARCHAR(3000)
)

-> ID를 입력하면 @return_table을 출력해주는 함수 f_info2를 만들라는 뜻
   @return table 이란 테이블이라는 뜻으로 returns @변수명 table을 사용
   table에 들어갈 필드 : FIN_NAME, FIN_VAL, FDATE, FPRD, Name

select R.FIN_NAME
, R.FIN_VAL
, R.FDATE
, R.FPRD
, A.Name
from companyinfo A
join IDMap I
on A.ID=I.ID
join Ratios R
on I.FIN_ID=R.FIN_ID
where A.ID=@ID

-> R의 FIN_NAME, FIN_VAL, FDATE, FPRD를 A의 Name을 열로 가지는 테이블을 반환하라는 뜻
   - A와 I는 ID를 기준으로 조인
   - R과 I는 FIN_ID를 기준으로 조인
   - A의 ID가 존재하는 데이터만 추출

insert into @return_table

-> select문에 쓴 다수의 데이터를 insert 하라는 뜻
   입력 데이터가 들어갈 부분에 select문으로 조회하는 쿼리를 넣음 -> 조회된 결과가 테이블에 insert됨
   조회 결과와 insert에 정의한 칼럼이 일치해야 함
*/

--함수 삭제하기
drop function f_info2

/*

함수
 - SQL 내장함수 : 지금까지 배워온 함수
 - 사용자 정의함수 : Scalar 함수(SUM이나 AVG처럼 값을 반환하는 함수), Tabel 함수

1. Scalar 함수

 create function<function_name>(       -> 원하는 함수 이름
 @<input_variable>                     -> 값을 담을 수 있는 매개변수 / 필요하지 않으면 생략 가능
 )
 returns<data_type>                    -> 반환되는 값의 타입, data형 지정
 as
 begin
 <sql_query>
 return<return_value>
 end

2. 테이블을 반환하는 함수 1

 create function<function_name>(
 @<input_variable>
 )
 returns table
 as
 return(<return_tabel_query>)

3. 테이블을 반환하는 함수 2
 
 create function<function_name>(
 @<input_variable>
 )
 returns @return_table table
 (
 <table definition>
 )
 as
 begin

 <query>
 insert into @return_table<table_return_query>

 return
 end

 ->begin과 end 사이에 다양한 프로그래밍 작업을 할 수 있다는 장점

4. 함수의 삭제와 수정

삭제 : drop function <function_name>
수정 : alter function <function_name>

*/
use study
go
select*from companyinfo

--employees 기준으로 순위 매기기
select name
, employees
, ROW_NUMBER() over (order by employees DESC) as 순위
from companyinfo
order by 순위

--ID가40853인 삼성전자의 종가, 어제종가, 내일종가를 한꺼번에 보여주기
select date_
, close_ as 종가
, lag(close_,1) over (order by date_) as 어제종가
, lead(close_,1) over (order by date_) as 내일종가
from stockprice
where ID=40853
order by Date_

--lag, lead함수를 이용해 오늘수익률과 내일수익률 구하기
select date_
, close_/lag(close_,1)over(order by date_)-1 as 오늘수익률
, lead(close_,1)over(order by date_)/close_ -1 as 내일수익률
from stockprice
where ID=40853
order by date_

--국가별 고용인 크기별 순위 확인하기
select name
, incinCtryCode
, rank()over(partition by IncInCtryCode order by Employees DESC) as 순위
from companyinfo

--국가별 고용인 크기별 순위 확인하기 (Null 제거 ver)
select name
, incinCtryCode
, rank()over(partition by IncInCtryCode order by Employees DESC) as 순위
from companyinfo
where IncInCtryCode is not null
order by 순위

--ID기준으로 수익률 계산하기
select date_
, ID
, close_/lag(close_,1)over(partition by ID order by date_)-1.0 as 수익률
from stockprice

--주식 가격 이동평균 구하기
select date_
, ID
, close_
, avg(close_)
over(partition by ID
order by date_ rows between
2 PRECEDING and 0 PRECEDING) as SMA3
from stockprice

/*

partition by절
 - 실전에서 가장 자주 사용하는 문법
 - 금융 관련 데이터를 다룰 때 자주 활용
 - 순위함수, 이동함수와 함께 많이 사용된다 

순위함수
 - row_number() : 중복 순위 무시, 동일한 값이 있어도 일단 순위를 매기는 함수 (동일한 순위 존재 X)
 - rank() : 중복순위를 적용하며, 다음 순위가 중복 순위 적용 후의 순위가 되며, 동일한 값일 경우 동일 순위 
 - dense_rank() : 중복 순위 적용하며, 다음 순위가 중복 순위 적용 후 +1을 함
 (rank 같은 경우 공동 2등이 2명일 경우 다음 순위 4등 / dense 같은 경우 공동 2등 2명이어도 다음 순위 3등)

순위 함수 예시
select coulumns, 순위함수()over(order by columns)
from table_name
where condition

이동함수
 - SQL Server에서는 2012년 이후 버전부터 사용 가능
 - lag는 이전행의 값을 가져올때 사용
 - lead는 다음 행의 값을 가져올 때 사용함
   >> lag, lead 함수는 변화율을 계산할 때 필수적으로 사용
      * 변화율 = (현재값-이전값)/이전값 = (현재값/이전값)-1

이동함수 예시
select columns, lead(column1, offset)
over(order by columns)
from table_name
where condition
  >> offset 생략 시 1행의 앞(뒤) 값을 가져오며, 값을 지정할 경우 지정한 값만큼의 데이터를 가져옴

partition by
 - group by와 동일하게 어떤 그룹에 적용하는 함ㅅ
 - 그룹을 나누어서 해당 레코드의 순위를 살펴보거나 이동함수 등을 적용할 때 사용

partition by 예시
select function ()over(partition by columns[order by columns])  >partion by 뒤에 있는 columns가 분할 기준이 되는 열
from table_name
where condition
*/


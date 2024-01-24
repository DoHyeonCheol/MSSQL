use study
go
select*from companyinfo


--주식가격과 기업의 정보를 연결하기
select companyinfo.Name
, StockPrice.Date_
, StockPrice.Close_
from companyinfo
join StockPrice
on companyinfo.ID=StockPrice.ID

--주식가격과 기업의 정보를 연결하기 (ALIAS를 이용해 코드 간소화하기)
select c.Name
, S.Date_
, S.close_
from companyinfo C
join StockPrice S
on C.ID=S.ID

--두 테이블을 Left Join문에 IND_ID 열 기준으로 연결하기
select C.Name
, C.IND_ID
, I.IND_Name
from companyinfo C
left join Industryinfo I
on C.IND_ID = I.IND_ID

--두 테이블을 full outer join 문에 IND_ID 열 기준으로 연결하기
select C.Name
, C.IND_ID
, I.IND_Name
from companyinfo C
full outer join Industryinfo I
on C.IND_ID = I.IND_ID

--여러 테이블을 join으로 중첩해서 연결하기
select c.Name
, C.ID
, D.FIN_ID
, D.Description
from companyinfo C
join IDMap I
on C.ID = I.ID
join Descriptions D
on I.FIN_ID = D.FIN_ID



/*

join이란?
 - SQL의 가장 강력한 기능이자, SQL SELECT로 수행할 수 있는 매우 중요한 작업
 - 데이터베이스 안에 여러 테이브레 따로 저장되어 있는 정보 > 하나로 연결하는 기능
   (특별한 구문을 사용해 여러 테이블을 연결해 하나의 결과를 반환하는 것)

join 예시
select column1, column2, ...
from table1_name join table2_name
on table1_name.columnA = table2_name.columnA
and table2_name.columnB = table2_name.columnB
...

연결하고자 하는 두 테이블은 서로 같은 정의의 열을 가지고 있어야 함
조인할 테이블을 join으로 정의하고 그 기준이 되는 열을 on으로 지정 (하나의 열, 여러 열 모두 기준으로 할 수 있음)

Join의 종류
 1. Inner JOin  (조인에서 대부분을 차지하므로 생략가능)
  - 일반적인 join
  - 두 테이블에 모두 존재하는 행을 기준으로 결합
 2. Left Join
  - 왼쪽 테이블의 모든 레코드는 일단 가져오고 일치하는 오른쪽 레코드를 붙여줌
  - 오른쪽 테이블에 데이터가 없으면 NULL로 채움
 3. Right Join
  - left join과 같지만 오른쪽 테이블 기준임
 4. Full Outer Join
  - 양쪽의 모든 레코드를 가져오고 일치하지 않는 부분은 null로 채움

left join 예시
select column1, column2, ...
from table1_name left join table2_name
on table1_name.columnA = table2_name.columnA
and table1_name.columnB = table2_name.columnB
...

right join 예시 (실무에서는 사용을 잘 안함)
select column1, column2, ...
from table1_name right join table2_name
on table1_name.columnA = table2_name.columnA
and table1_name.columnB = table2_name.columnB
...

full outer join 예시
 - 모든 조합을 인단 다 감안하는 방법
 - 두 테이블로 나올 수 있는 모든 경우의 수로 연결한 다음 조건을 찾아 나가는 형식
 - join과 left join, right join의 결과를 모두 합친 결과

select column1, column2, ...
from table1_name full outer join join table2_name
on table1_name.columnA = table2_name.columnA
and table1_name.columnB = table2_name.columnB
...

join을 중첩하는 syntax
 - join은 계속 중첩해서 사용할 수 있음
 -문법 자체는 특별히 달라지는게 없고 join을 연속해서 사용하기만 하면 됨

예시
select column1, column2, ...
from table1_name 
join table2_name
on table1_name.columnA = table2_name.columnA
and table1_name.columnB = table2_name.columnB
join table3_name
on table1_name.columnB = table2_name.columnC
...

join구문
 - 관계형 데이터베이스가 주류가 되도록 만든 주역
 - 데이터 성격별로 테이블을 따로 구분하고 합칠  때는 join을 사용하여 원하는 형태로 보여주는 방식이 RDB의 핵심
   (RDB : 데이터 관리 용이, 적은 공간 사용, 빠른 검색)

*/
use study
go
select*from companyinfo

--서브쿼리를 이용해 원하는 데이터 필터링하기 (서울 소재 기업의 2020.10.12 주식가격을 반환하기 + 주식가격이 50만원 이상인 내용)
select seoul.name, seoul.close_
from
(select A.Name, S.Date_, S.close_
from companyinfo A
join StockPrice S
on A.ID = S.ID
where city = 'Seoul' and S.Date_ = '20201012'
)seoul
where close_>=500000

--서브쿼리를 단일 값처럼 사용해서 데이터 가져오기
select*
from stockprice
where id = 40853
and close_ = (select max(close_) from stockprice where id = 40853)

--단일 열 서브쿼리 넣어 데이터 불러오기
select name
from companyinfo
where ID IN
(SELECT ID
FROM StockPrice S
Group by ID
having max(close_)>=500000
)

--vw_stockpricewithname 이름의 view 생성하기
create view vw_stockpricewithname
as
select a.Name
, a.ID
, s.Date_
, s.close_
from companyinfo a
join stockprice s
on a.id = s.id


--view를 이용해 코드 만들기
select*
from vw_stockpricewithname
where name = 'nvidia'
order by date_

--view 제거하기
drop view vw_stockpricewithname  -- 더 이상 사용할 수 없음

--with를 이용해 서브쿼리 재활용하기
with cte_price as
(
select a.Name
, a.ID
, s.Date_
, s.close_
from companyinfo a
join stockprice s
on a.id = s.id
)
select*from cte_price where Name='NVIDIA'



/*

서브쿼리

1. Nested Subquery : 단일 값
2. Inline Subquery : 단일 열 테이블      -> 1,2,3 모두 괄호로 묶여 있음
3. Scalar Subquery : 다중 열 행렬

서브쿼리를 이용하는 syntax
: 원래 테이블이 존재하던 위치에 서브쿼리의 결과가 하나의 테이블 형태가 되면 사용할 수 있음

기본 예시
select SubQueryName.Column1, ubQueryName.Column2, ...
from (서브쿼리) SubQueryName

단일 값 형태의 서브쿼리를 이용하는 syntax
: 단일 값을 반환한기에 값이 활용되는 모든 위치에 괄호 형태로 들어갈 수 있음

기본 예시
select(서브쿼리0), SubQueryName.column2, ...
from table_name1
where column1 = (서브쿼리1) or column2 >= (서브쿼리2) ...

단일 열 테이블
 - 열이 하나밖에 없는 테이블
 - 테이블 위치에서도 사용할 수 있지만 where 절에서도 사용할 수 있음
 - where 절에서는 주로 in 구문을 함께 사용

in
 - 한 칼럼에 여러 값 조건들을 넣고 싶을 때 사용
 - 한 칼럽에 대하여 or 구문을 너무 자주 쓰게 되는 경우 코드가 지저분해져서 나오게 된 코드

ex) 칼럼이 A이거나 B이거나 C 중 하나이면 반환해라
or 사용 : 칼럼 = A or 칼럼 = B or 칼럼 = C
in 사용 : 칼럼 in (A, B, C)

서브쿼리 장,단점
 - 장점 : 다양한 위치에서 사용 가능하며, 여러 번 중첩해서 사용 가능함
 - 단점 : 서브쿼리가 너무 많아지면 코드가 지나치게 복잡해져 읽기 힘들어짐 > 코드의 가독성이 떨어짐
   -> 자주 사용하는 서브쿼리를 하나의 문장으로 저장해 테이블처럼 사용하도록 도와주는 view 기능

View
 - 하나 이상의 기본 테이블로 부터 유도된, 이름을 가지는 가상의 테이블
 - 저장장치 내에 물리적으로 존재하지 않지만 사용자에게 있는 것처럼 사용
 - 필요한 데이터만 뷰로 정의해서 처리할 수 있기에 관리가 용이하고 명령문이 간단함

view를 이용하는 syntax
create view 뷰 이름
as
select를 사용한 쿼리문

view를 제거하는 synrax
drop view 뷰 이름

with 구문
 - 서브쿼리를 재사용하는 방법 중 view 처럼 create, drop 등으로 코드를 생성하지 않고도 쓸 수 있는 방법
 - 다른 코드에서의 반복 사용성이 낮은 경우 view보다 with가 더 유용

with [별명][(칼럼명[,칼럼명2])]as)
 sub query
)
[별명을 사용하는 main query]

*/
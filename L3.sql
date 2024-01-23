use study
go
select*from companyinfo

--ID가 40853인 회사 찾기
select*from companyinfo
where id=40853

--ID 값이 40853인 기업의 최고가, 최소가, 평균가격 알아보기
select max(close_) as 최고가, min(close_) as 최소가, avg(close_) as 평균가
from stockprice
where id = 40853

--ID 값이 40853인 기업의 최고가, 최소가, 평균가격 알아보기 (as 제거 ver.) - No column name으로 출력
select max(close_), min(close_), avg(close_)
from stockprice
where id = 40853

--stockprice 테이블을 사용해 기업별 최대, 최소, 평균, 거래일수 확인하기
select max(close_) as 최고가, min(close_) as 최소가, avg(close_) as 평균가, count(close_) as 거래일수
from stockprice
group by ID
order by 거래일수
--order by로 거래일수 작은 순서에서 큰 순서로 정렬

--companyinfo 테이블을 사용해 도시를 기준으로 각 기업이 몇 명을 고용했는지 알아보기
select city
, sum(employees) as 고용인    -- 고용인 총합
, max(employees) as 최대고용  -- 최대로 고용한 회사의 고용인 수
, count(*) as 회사수          -- 도시에 존재하는 숫자 (테이블의 모든 행의 개수)
from companyinfo
group by city
order by 고용인 DESC 

--고용인이 200만 명 이상인 도시 알아보기
select city
, sum(employees) as 고용인    
, max(employees) as 최대고용  
, count(*) as 회사수          
from companyinfo
group by city
having sum(employees)>=2000000
order by 고용인 DESC 

/*

집계함수 
: 열의 개수, 합계, 평균 등을 계산하는 함수이며, 특정 그룹별로 그 수치를 알아보는 데 사용

ex) avg() : 열의 평균
	--------------------------
    count() : 열의 행 개수
	max() : 열의 최댓값                 문자, 날짜 유형에서도 적용 가능
	min() : 열의 최솟값
	--------------------------
	sum() : 열의 합계
	stdev() : 표준편차

as : 추출한 열에 이름을 붙이는 방법  >> ALIAS

group by 절을 이용해 그룹 만들기
: 그룹을 만들려면 select 문에서 group by 절을 사용
 > SQL문에서 from 절과 where 절 뒤에 오며 행들을 그룹화

group by 예시
select column_name(s)
from table_name
where condition
group by column_name(s)   - 성별, 지역, 회사 등 그룹을 정확히 나눌 수 있을 만한 열들로 지정

having
: group by에서 나온 결과 중에서 원하는 조건에 부합하는 결과만 보고 싶을 때 사용함
  무조건 group by 절과 함께 사용
  조건은 where절에 기술하지만 having 집계함수로 조건을 필터링할 때 사용
   > group by를 통해 지정한 그룹의 집계 특성에 조건을 부여해서 결과를 봄

having 예시
select column_name(s)
from table_name
where condition
group by column_name(s)
having condition
*/
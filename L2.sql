use study
go
select*from companyinfo
select name, city, IncInCtryCode from companyinfo
--콤마(,)하나에 오류가 나오니 유의할 것

--select에 distinct 결합해 중복되지 않게 테이블 반환하기
select distinct IncInCtryCode from companyinfo

--IncInCtryCode의 값이 KOR인 데이터만 가져오기
select*from companyinfo where IncInCtryCode='kor'
--필드 값이 텍스트인 경우 ''넣고, 숫자인 경우 그대로 사용해도 문제 없음

--Employees가 10만 이상인 기업 레코드 가져오기
select*from companyinfo where Employees>=100000  --조건연산자 사용 예시

--IncInCtryCode 값이 kor이면서 Employees가 5만 이상인 기업 레코드 가져오기
select*
from companyinfo 
where IncInCtryCode='kor' and Employees>=50000

--city값이 Seoul이거나 Busan인 기업레코드 가져오기
select*
from companyinfo 
where city='seoul' or city='busan'

--IncInCtryCode 값이 USA가 아닌 모든 기업 레코드 가져오기
select*
from companyinfo 
where not IncInCtryCode='USA'

--IncInCtryCode 값이 USA도 아니고 JPN도 아닌 기업 레코드 가져오기
select*
from companyinfo 
where not IncInCtryCode='USA' 
and not IncInCtryCode='JPN'

--'a'로 시작하는 모든 기업 찾기
select*from companyinfo where name like 'a%'

--'a'로 시작하고 뒤에는 4개의 문자로 이루어진 기업 찾기
select*from companyinfo where name like 'a____'

--국가코드의 알파벳 순서대로 정렬하기
select IncInCtryCode, Employees, name
from companyinfo
order by IncInCtryCode

--국가코드의 알파벳 순서대로 정렬하기 (NULL 삭제 ver)
select IncInCtryCode, Employees, name
from companyinfo
where IncInCtryCode is not null
order by IncInCtryCode

--국가코드의 알파벳 순서대로 Eployees는 큰 값에서 작은 값으로 정렬하기 (NULL 삭제 ver)
select IncInCtryCode, Employees, name
from companyinfo
where IncInCtryCode is not null
order by IncInCtryCode, Employees DESC


/*
use 
뒤에 구체적인 DB를 지정하지 않을 경우 RDBMS는 로그인된 첫 번쨰 장소인 master 데이터베이스에 데이터를 요청

go
이전의 코드를 실행 후 다음 코드를 실행하라고 지정함
여러 작업을 한 코드에서 실행시킬 떄 작업별로 구분해주기 위해 사용

use를 사용하지 않는 방법
select*from study.dbo.companyinfo 를 입력

dbo는 database owner의 약자로 보통 99%는 dbo이므로 마침표(.)로 입력함

위의 코드를 다음과 같은 방식으로 표현할 수 있음 selcet*from study..companyinfo

select문
: 데이터베이스에서 데이터를 가져오는 데 사용 (결과값은 테이블 형식)

ex)   select column1, column2, ...
      from table_name

만약 모든 테이블을 가져오고 싶다면 select*from table_name 사용

distinct 코드
: 서로 다른 값만을 반환할 수 있으며 중복되는 행을 하나로 보여주는 distinct 코드

ex)   selcet distinct column1, column2, ...
      from table_name

where코드
: 방대한 양의 데이터가 들어 있는 데이터베이스 테이블 (특정 용도에 맞는 내용만 가져와 작업이나 보고에 사용)
  원하는 데이터만 가져오며, 조건연산자를 사용할 수 있음

ex)   select column1, column2, ...
      from table_name
	  where condition     (condition은 조건)

조건 연산자
and : 둘 다 만족하는 레코드를 반환
or : 둘 중 하나라도 만족하는 레코드를 반환
not : 해당 조건을 만족하지 않는 레코드를 반환

and 예시
select column1, column2, ...
from table_name
where condtion1 and condition2....

or 예시
select column1, column2, ...
from table_name
where condtion1 or condition2....

not 예시
select column1, column2, ...
from table_name
where not condtion1

like 연산자
: 정확히 특정한 패턴을 가지는 값을 찾을 때 사용
  ex) 고객 이름에 알파벳 "P"가 포함된 고객만을 찾을 때
      기업 이름 중간에 BIO같은 문장이 있는 기업을 찾을 때

like 예시
select column1, column2, ...
from table_name
where condition like pattern

와일드카드
: 패턴을 정의하기 위해 사용되는 특수 문자 (%, _ 를 주로 사용함)
  % : 모든 문자열 의미
  _ : 한 문자를 의미
다른 검색에 비해 오랜 시간이 걸려 성능을 저하 시킬 수 있으므로 반드시 필요한 경우가 아닐 경우
검색 패턴의 시작 부분에는 쓰지 않는 편이 좋음

데이터 정렬하기

order by를 이용해 원하는대로 데이터를 정렬하기
내림차순 정렬은 desc, 오름차순 정렬은 asc
필드가 숫자면 숫자의 크기에 따르고 문자면 알파벳 순서를 따름

order by 예시
select column1, column2, ...
from table_name
order by column1, column2, ... desc     기본은 오름차순이기에 asc를 입력하지 않아도 asc로 정렬

*/


use study
go
select*from companyinfo

--employees에 집계함수 적용하기
select sum(employees) as 합계
, avg(employees) as 평균
, max(employees) as 최대
, min(employees) as 최소
, count(employees) as 갯수
from companyinfo

--문자열 함수 적용하기
print len(' Abc Def Fed CBa ')                        --문자열 길이 반환
print ltrim(' Abc Def Fed CBa ')                      --선행 공백 제거
print rtrim(' Abc Def Fed CBa ')                      --후행 공백 제거
print upper(' Abc Def Fed CBa ')                      --모든 문자를 대문자로 표시
print lower(' Abc Def Fed CBa ')                      --모든 문자를 소문자로 표시 
print left(' Abc Def Fed CBa ', 6)                    --왼쪽에서 6자 출력
print right(' Abc Def Fed CBa ', 6)                   --오른쪽에서 6자 출력 
print reverse(' Abc Def Fed CBa ')                    --거꾸로 출력
print replace(' Abc Def Fed CBa ', 'Abc', 'ZZZ')      --특정 패턴을 찾아서 있으면 치환
print replicate('HI', 10)                             --특정 문자열 반복
print'['+space(10)+']'                                --공백을 여러개 출력
print str(12345) + '6789'                             --정수형을 문자열로 변환
print substring(' Abc Def Fed CBa ', 6, 3)            --문자열 검색 : 어디서부터 몇 자 검색
print charindex('Def', ' Abc Def Fed CBa ')           --특정 문자열의 위치값 검색

--날짜 함수 적용하기
print getdate()                                       --현재를 반환
print year(getdate())                                 --년도를 반환
print month(getdate())                                --월을 반환
print day(getdate())                                  --날짜를 반환
print datediff(day,getdate(), '2012-12-25')           --두 날짜 간의 차이를 반환
print dateadd(month, 3, getdate())                    --날짜를 더함

--숫자 2020과 '년'을  결합하는 코드 만들기
print cast(2020 as varchar) + N'년'
print convert(varchar, 2020) + N'년'
-- > 문자 앞에 N을 붙이는 이유 : 유니코드임을 알려주기 위해
-- >                            N 생략시 SSMS는 문자열을 인식하지 못해 2020???를 반환

--날짜를 문자열로 변환하는 코드 만들기
print cast(getdate() as varchar)
print convert(varchar(8), getdate(), 112)
--> cast는 출력값은 단순히 문자열로 바꾸는 반면, convert는 날짜를 년월일 형태로 변환


/*

데이터의 타입

모든 테이블의 열은 각각 데이터 타입을 가짐
 ex) 정수, 실수, 문자, 날짜, 이미지, 바이너리, xml
내가 사용하는 테이블에 존재하는 열들의 데이터 타입을 알아야 데이터를 어떻게 처리해야 하느지 알 수 있음

1. 문자 유형

데이터 타입            설명                 가능한 크기
char(n)            고정 문자열           최대 8,000문자
varchar(n)         가변 문자열           최대 8,000문자
varchar(max)       가변 문자열           최대 1,073,741,824문자
nchar           고정 유니코드 문자열     최대 4,000문자
nvarchar(n)     가변 유니코드 문자열     최대 4,000문자
nvarchar(max)   가변 유니코드 문자열     최대 536,879,912문자

(앞에 n이 붙은 이유는 영어가 아닌 다른 국가 언어를 저장하기 위해서)

2. 숫자 유형

데이터 타입                  설명                    가능한 크기
tinyint                    0 ~ 255                   1바이트
smallint             -32,768 ~ 32,767                2바이트
int           -2,147,483,648 ~ 2,147,483,647         4바이트
bigint                 -2^63 ~ 2^63-1                8바이트 
decimal(p,s)        -10^38+1 ~ 10^38-1             5~17바이트           (p는 자리수, s는 소수점자리 수)
numeric(p,s)        decomal과 기능상 동일           5~17바이트  
smallmoney             -21억 ~ 21억 화폐              4바이트
money                -2^63 ~ 2^63-1 화폐              8바이트
float           -1.79E+308 ~ 1.79E+308 실수          4~8바이트
real             -3.40E+38 ~ 3.40E+38 실수            4바이트


3. 날짜타입

데이터 타입                        설명                        가능한 크기
datetime               1753-1-1 ~ 9999-12-31, 3.33ms            8바이트
datetime2              0001-1-1 ~ 9999-12-31, 100ns            6~8바이트
smalldatetime           1900-1-1 ~ 2079-6-6, 1min               4바이트
date                   0001-1-1 ~ 9999-12-31, 1day              3바이트
time                    100ns단위 날짜 없이 시간만              3~5바이트

집계함수 종류

sum (합계) / avg (평균) / max (최대) / min (최소) / count (개수)

문자열 관련 함수

substring(문자열, p, n) : 문자열의 p 위치에서 n개의 문자들을 반환하게 함
replace(문자열, pattern, new) : 문자열에서 pattern과 일치하는 부분을 new로 바꿈
charindex(pattern, 문자열) : pattern이 문자열의 어디에 위치하는지 반환함

날짜 관련 함수

getdate() : 현재의 날짜와 시각을 datetime 유형으로 반환
year/month/day(getdate()) : 각각 이름이 뜻하는 것처럼 현재의 년도, 월, 날짜를 반환 
datediff(year/month/day(getdate(), '비교 년 월 일') : 두 날짜 간의 차이를 반환
dateadd(year/month/day, 숫자, getdate()) : 주어진 숫자만큼 년도, 월, 날짜를 더함

형식 변환 함수

cast 
 - 문자열을 숫자로 바꿈         ex) "1111" -> 1111 (반대도 가능)
 - 기본적인 형 변화 작업 수행   ex) 10 19 2020 4:41PM -> 20201019 
convert
 - 사용자가 원하는 형태의 데이터로 변환    ex) 234번지 -> "234" + "번지"
 - 추가 파라미터에 대한 공부 필요
cast와 convert은 변환하는 코드의 방식이 다르나 같은 작업을 수행

*/
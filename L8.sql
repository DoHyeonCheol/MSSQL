--Persons 이름의 새로운 테이블 만들기
create table Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
)

--새로 만든 테이블 확인하기
go
select*
from Persons

--만든 테이블 제거하기
drop table Persons

--다시 동일한 테이블 만들기
create table Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
)

--새로운 열 추가하기
alter table Persons add newcol int
go
select*
from Persons
--> go 부터는 테이블을 보기 위해 사용

--기존의 열 삭제하기
alter table Persons drop column newcol
go
select*
from Persons

--데이터 타입 변경하기
alter table Persons alter column PersonID varchar(255)
go
select*
from Persons

--Persons 테이블에 데이터 넣기
insert into persons(LastName, FirstName)
values('ALFRED', 'HITCHCOK')     --> 콤마(,)를 넣지 않을 경우 오류가 발생하니 유의할 것
go
select*
from persons

--전체 칼럼에 데이터 한번에 넣기
insert into Persons values(20, 'ALFRED', 'HITCHCOK', 'T ROAD 112', 'SEOUL')
go
select*
from persons

--PersonID가 NULL인 행 삭제하기
delete from Persons where PersonID is NULL
go
select*
from Persons

--Persons 테이블의 PersonID가 20인 행의 데이터 수정하기
update persons
set address = 'jagalchiro 112', city = 'BUSAN'
where PersonID = 20
go
select*
from Persons

--Customers 테이블을 생성하면서 ID와 이름에 NOT NULL 제약 조건 설정하기
create table Customers(
ID int not null,
LastName varchar(255) not null,
FirstName varchar(255) not null,
Age int
)

--Customers 테이블에 데이터 넣기
insert into customers(ID, AGE) values(10,30)  --> 실패 (ID와 이름이 Not null로 설정되었기 때문에)

--Customers 테이블의 ID를 NOT NULL이면서 UNIQUE 하도록 제약 조건 넣기
drop table customers
go
create table Customers(
ID int NOT NULL UNIQUE,
LastName varchar(255) not null,
FirstName varchar(255) not null,
Age int
)
go
insert into Customers values(10,'A','B',20)
insert into Customers values(10,'C','D',20)
--> 첫번째 insert는 성공했지만 두번째 insert에 ID도 10이기에 Unique 제약조건을 위반하였음 - 따라서 실패

--primary key로 ID 지정하기
alter table Customers add constraint
PK_Customers primary key(ID)

--primary key 제거하기
alter table Customers drop constraint PK_Customers

drop table Customers

--두 개의 테이블을 새로 만들고 PK를 이용해 데이터 입력하기
create table Customers(
ID int Primary Key,
LastName varchar(255) Not Null,
FirstName varchar(255) Not Null,
Age int
)
Go

create table Orders(
OrderID int Not Null Primary Key,
OrderNumber int Not Null,
PersonID int Foreign Key references Customers(ID)
)

--새로 만든 테이블에 데이터 넣어주기
insert into Customers Values (10, 'A', 'B', 20)
insert into Customers Values (11, 'A', 'D', 22)
insert into Customers Values (12, 'A', 'Z', 21)
insert into Customers Values (13, 'A', 'zzz', 32)

insert into Orders values(1,20,13)
insert into Orders values(1,20,14)  -->  Customers 테이블에 ID가 14인 값이 없기 떄문

--> 정리하자면 Customers에 존재하는 ID에 대해서만 Orders에 데이터 삽입 가능하며
--> Orders에 존재하는 ID에 대해서만, Customers에 데이터 삽입 가능
--> 즉, 두 테이블에 모두 존재하는 ID만 가능하다는 것을 의미 함


/*

1. 테이블을 만드는 syntax
create table table_name(
  column1 datatype,
  column2 datatype,
  ....
)
-> column은 열, 필드의 이름을 뜻하며, datatype은 열이 어떤 데이터 타입인지를 미리 정의
   (한 열에는 동일한 데이터 타입을 가진 데이터만 존재 가능)

새로만든 테이블을 확인 하는 방법
go
select*
from table_name

2. 테이블을 제거하는 syntax
drop table table_name
: 입력과 동시에 테이블이 제거됨

3. 테이블 변경(alter)
 - 이미 존재하는 테이블을 변경할 때 사용
 - 열을 추가하거나 삭제할 때 열의 타입 등을 바꾸거나 제약 조건 등을 추가 할 때 사용

alter table table_name add column_name datatype          <- 새로운 열 추가
alter table table_name drop column column_name           <- 기존 열 제거
alter table table_name alter column column_name          <- 데이터 타입 변경

4. 데이터 핸들링
: 데이터 추가, 수정, 삭제하는 명령어

- insert
: 데이터를 넣는 기능 (칼럼을 지정해서 넣는 방법 or 전체 칼럼에 한꺼번에 넣는 방법)

 칼럼을 지정해서 넣는 방법
 insert into table_name(column1, column2, column3, ...)  -> 지정된 열에 값을 입력 후 나머지 열에는 NULL
 values(value1, value2, value3, ...)

 전체 칼럼에 한꺼번에 넣는 방법
 insert into table_name values(value1, value2, value3, ...) -> 칼럼 개수와 일치하게 입력, 칼럼 지정 필요 X

- delete
: 테이블 데이터를 삭제하는 기능
 delete from table_name
 where condition

- update
: 테이블 데이터를 수정하는 기능
 update table_name
 set column1 = value1, column2 = value2, ...  -> 업데이트할 열들을 지정 후 값을 할당(where 조건을 만족하는 행의 열만 대상으로 함)
 where condition

5. 테이블 제약 조건
 - 테이블에 일종의 규칙을 지정
 - 제약조건을 위배하는 데이터는 테이블에 존재할 수 없음
 - 테이블 생성 시 지정 가능
 - alter 구문으로 변경 지정 가능

  > NOT NULL        : NULL값이 들어올 수 없음
  > UNIQUE          : 열에 있는 모든 값들은 서로 다른 값을 가져야 함
  > PRIMARY KEY     : 해당 열이 Primary Key가 되며, Not null이면서 Unique 해야 함
  > FOREIGN KEY     : 다른 테이블에 존재하는 열과 Join되었을 때 그 조합이 Primary Key가 되어야 함
  > DEFAULT         : 열이 생성될 때 사용자가 지정하지 않으면 Default 값이 지정됨

6. 중요 제약 조건 (Primary Key, Foreign Key)
 
 Primary Key 
 - 행(record)을 유일하게 구분하게 만드는 열의 규칙
  ex) 인명 테이블에서 주민등록번호
 - 조합을 통해서도 설정 가능
  ex) 이름 + 주소 + 성별

 alter table table_name add constraint PK_table_name
 primary key(column)                                     -> 설정
 alter table table_name drop constraint PK_table_name    -> 삭제

 ***** Primary Key로 설정된 열은 반드시 유일하고 Unique 값이 존재해야 하며, NOT NULL이어야 함

 Foreign Key
 - 두 개 이상의 테이블이 존재할 때 의미가 있음
 - 다른 테이블의 primary key를 가리키는 열

 alter table table_name
 add constraint FK_table_name foreign key (column) preferences table_name2(column)
 alter table name drop constraint FK_table_name

 -> preferences : 목표가 되는 테이블을 명시하며 해당 테이블에서 PK인 칼럼을 지정

*/
--Persons �̸��� ���ο� ���̺� �����
create table Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
)

--���� ���� ���̺� Ȯ���ϱ�
go
select*
from Persons

--���� ���̺� �����ϱ�
drop table Persons

--�ٽ� ������ ���̺� �����
create table Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
)

--���ο� �� �߰��ϱ�
alter table Persons add newcol int
go
select*
from Persons
--> go ���ʹ� ���̺��� ���� ���� ���

--������ �� �����ϱ�
alter table Persons drop column newcol
go
select*
from Persons

--������ Ÿ�� �����ϱ�
alter table Persons alter column PersonID varchar(255)
go
select*
from Persons

--Persons ���̺� ������ �ֱ�
insert into persons(LastName, FirstName)
values('ALFRED', 'HITCHCOK')     --> �޸�(,)�� ���� ���� ��� ������ �߻��ϴ� ������ ��
go
select*
from persons

--��ü Į���� ������ �ѹ��� �ֱ�
insert into Persons values(20, 'ALFRED', 'HITCHCOK', 'T ROAD 112', 'SEOUL')
go
select*
from persons

--PersonID�� NULL�� �� �����ϱ�
delete from Persons where PersonID is NULL
go
select*
from Persons

--Persons ���̺��� PersonID�� 20�� ���� ������ �����ϱ�
update persons
set address = 'jagalchiro 112', city = 'BUSAN'
where PersonID = 20
go
select*
from Persons

--Customers ���̺��� �����ϸ鼭 ID�� �̸��� NOT NULL ���� ���� �����ϱ�
create table Customers(
ID int not null,
LastName varchar(255) not null,
FirstName varchar(255) not null,
Age int
)

--Customers ���̺� ������ �ֱ�
insert into customers(ID, AGE) values(10,30)  --> ���� (ID�� �̸��� Not null�� �����Ǿ��� ������)

--Customers ���̺��� ID�� NOT NULL�̸鼭 UNIQUE �ϵ��� ���� ���� �ֱ�
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
--> ù��° insert�� ���������� �ι�° insert�� ID�� 10�̱⿡ Unique ���������� �����Ͽ��� - ���� ����

--primary key�� ID �����ϱ�
alter table Customers add constraint
PK_Customers primary key(ID)

--primary key �����ϱ�
alter table Customers drop constraint PK_Customers

drop table Customers

--�� ���� ���̺��� ���� ����� PK�� �̿��� ������ �Է��ϱ�
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

--���� ���� ���̺� ������ �־��ֱ�
insert into Customers Values (10, 'A', 'B', 20)
insert into Customers Values (11, 'A', 'D', 22)
insert into Customers Values (12, 'A', 'Z', 21)
insert into Customers Values (13, 'A', 'zzz', 32)

insert into Orders values(1,20,13)
insert into Orders values(1,20,14)  -->  Customers ���̺� ID�� 14�� ���� ���� ����

--> �������ڸ� Customers�� �����ϴ� ID�� ���ؼ��� Orders�� ������ ���� �����ϸ�
--> Orders�� �����ϴ� ID�� ���ؼ���, Customers�� ������ ���� ����
--> ��, �� ���̺� ��� �����ϴ� ID�� �����ϴٴ� ���� �ǹ� ��


/*

1. ���̺��� ����� syntax
create table table_name(
  column1 datatype,
  column2 datatype,
  ....
)
-> column�� ��, �ʵ��� �̸��� ���ϸ�, datatype�� ���� � ������ Ÿ�������� �̸� ����
   (�� ������ ������ ������ Ÿ���� ���� �����͸� ���� ����)

���θ��� ���̺��� Ȯ�� �ϴ� ���
go
select*
from table_name

2. ���̺��� �����ϴ� syntax
drop table table_name
: �Է°� ���ÿ� ���̺��� ���ŵ�

3. ���̺� ����(alter)
 - �̹� �����ϴ� ���̺��� ������ �� ���
 - ���� �߰��ϰų� ������ �� ���� Ÿ�� ���� �ٲٰų� ���� ���� ���� �߰� �� �� ���

alter table table_name add column_name datatype          <- ���ο� �� �߰�
alter table table_name drop column column_name           <- ���� �� ����
alter table table_name alter column column_name          <- ������ Ÿ�� ����

4. ������ �ڵ鸵
: ������ �߰�, ����, �����ϴ� ��ɾ�

- insert
: �����͸� �ִ� ��� (Į���� �����ؼ� �ִ� ��� or ��ü Į���� �Ѳ����� �ִ� ���)

 Į���� �����ؼ� �ִ� ���
 insert into table_name(column1, column2, column3, ...)  -> ������ ���� ���� �Է� �� ������ ������ NULL
 values(value1, value2, value3, ...)

 ��ü Į���� �Ѳ����� �ִ� ���
 insert into table_name values(value1, value2, value3, ...) -> Į�� ������ ��ġ�ϰ� �Է�, Į�� ���� �ʿ� X

- delete
: ���̺� �����͸� �����ϴ� ���
 delete from table_name
 where condition

- update
: ���̺� �����͸� �����ϴ� ���
 update table_name
 set column1 = value1, column2 = value2, ...  -> ������Ʈ�� ������ ���� �� ���� �Ҵ�(where ������ �����ϴ� ���� ���� ������� ��)
 where condition

5. ���̺� ���� ����
 - ���̺� ������ ��Ģ�� ����
 - ���������� �����ϴ� �����ʹ� ���̺� ������ �� ����
 - ���̺� ���� �� ���� ����
 - alter �������� ���� ���� ����

  > NOT NULL        : NULL���� ���� �� ����
  > UNIQUE          : ���� �ִ� ��� ������ ���� �ٸ� ���� ������ ��
  > PRIMARY KEY     : �ش� ���� Primary Key�� �Ǹ�, Not null�̸鼭 Unique �ؾ� ��
  > FOREIGN KEY     : �ٸ� ���̺� �����ϴ� ���� Join�Ǿ��� �� �� ������ Primary Key�� �Ǿ�� ��
  > DEFAULT         : ���� ������ �� ����ڰ� �������� ������ Default ���� ������

6. �߿� ���� ���� (Primary Key, Foreign Key)
 
 Primary Key 
 - ��(record)�� �����ϰ� �����ϰ� ����� ���� ��Ģ
  ex) �θ� ���̺��� �ֹε�Ϲ�ȣ
 - ������ ���ؼ��� ���� ����
  ex) �̸� + �ּ� + ����

 alter table table_name add constraint PK_table_name
 primary key(column)                                     -> ����
 alter table table_name drop constraint PK_table_name    -> ����

 ***** Primary Key�� ������ ���� �ݵ�� �����ϰ� Unique ���� �����ؾ� �ϸ�, NOT NULL�̾�� ��

 Foreign Key
 - �� �� �̻��� ���̺��� ������ �� �ǹ̰� ����
 - �ٸ� ���̺��� primary key�� ����Ű�� ��

 alter table table_name
 add constraint FK_table_name foreign key (column) preferences table_name2(column)
 alter table name drop constraint FK_table_name

 -> preferences : ��ǥ�� �Ǵ� ���̺��� ����ϸ� �ش� ���̺��� PK�� Į���� ����

*/
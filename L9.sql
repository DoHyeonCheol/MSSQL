--1. Scalar �Լ�

--f_plus �̸��� ���� �Լ� �����
create function f_plus(      
@value1 int,                   --> ���� ������ �����͸� ���´ٴ� �ǹ�
@value2 int                    --> f_plus�� �ΰ��� ���� ���ٴ� ���� �ǹ�
)
returns int                    
as
begin
declare @sum_value int                --> declare : ������ �����Ѵٴ� �� (declare @������<data type>)
set @sum_value = (@value1+@value2)    --> ������ ���� �Ҵ��Ϸ��� set�� Ȱ��
return @sum_value 
end

--f_plus �Լ� �̿��ϱ�
go
select dbo.f_plus(10, 20)

--stock price ���̺� ���캸��
use study
go
select*from StockPrice

--companyinfo ���캸��
use study
go
select*from companyinfo

--f_return �Լ� ����� (f_return : ������, ������, ����ڵ� �Է� �� �ش� ��¥ ������ ���ͷ��� �����ִ� �Լ�)
  --> @�ڿ� ���� �Ű����� �� 3�� (������ startdate / ������ enddate / ����ڵ� ID)
  --> �� �ڿ��� ������ ���¸� ��Ÿ���� date, int ���� ����

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
�� �ڵ� ����
returns decimal(12, 10)      -> �Լ��� ������� �Ҽ��� ���� 10��° �ڸ����� ���̴� ����
declare @startprice numeric  -> startprice ��� ������ ������ �����ͷ� �����Ѵٴ� ��
set 1 : @startdate�� ������ ��� ������ �����Ƿ� ���� ����� ���� �ŷ����� ã�� ���� �ڵ�
set 2 : @enddate�� ���� ����� �ŷ����� ã���� ���� �ڵ�
set 3,4 : close_������ �����ͼ� ���ͷ��� ���
*/

--f_return �Լ��� companyinfo�� �����ϴ� ��� ���� �����ϱ�
select c.*
, dbo.f_return('2020-10-01', '2020-10-12', ID) as ret
from companyinfo c


--2. ���̺��� ��ȯ�ϴ� �Լ� 1

--f_info �Լ� �����
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
�ڵ� ����
companyinfo = A / Ratios = R / IDMap = I

from companyinfo A
join IDMap I
on A.ID=I.ID
join Ratios R
on I.FIN_ID=R.FIN_ID

-> companyinfo A�� ���� IDMap I �� Ratios R�� ���ʴ�� ����
    - ���� A�� I�� �����ϵ�, ID�� �������� ����
	- �� �� I�� R�� ����, FIN_ID�� �������� ��
	-> A�� I�� ���� key�� ID, I�� R�� ���� key�� FIN_ID�̱� ����
	+ Ratios���� ����� �繫���� �����Ͱ� �����ϴµ�, ID�� �ƴ� FIN_ID�� ����ڵ�� �۵�
	+ IDMap�� �߰� �Ű��� FIN_ID�� ã�� �̸� �ѹ� �� join�� �ɾ� �繫 �����͸� ������

select R.FIN_NAME
, R.FIN_VAL
, R.FDATE
, R.FPRD
, A.Name

-> R�κ��� ���� FIN_NAME, FIN_VAL, FDATE, FPRD�� A�κ��� Name�̶�� �ʵ带 �����϶�� �� 

where A.ID=@ID

-> select�� �Բ� ������ �������� join �س��� ���̺��� Ư�� ���ǿ� �����ϴ� �����͸� ��ȸ�ϰ� ���� �� ���
   A.ID�� ���� �ʵ尡 �����ϴ� �����͸� �����϶�� ��
*/


--3. ���̺��� ��ȯ�ϴ� �Լ� 2

--f_info2 �Լ� �����
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
�ڵ� ����

create function f_info2(@ID int)
returns @return_table table
(
FIN_NAME varchar(300)
, FIN_VAL float
, FDATE Date
, FPRD int
, Name NVARCHAR(3000)
)

-> ID�� �Է��ϸ� @return_table�� ������ִ� �Լ� f_info2�� ������ ��
   @return table �̶� ���̺��̶�� ������ returns @������ table�� ���
   table�� �� �ʵ� : FIN_NAME, FIN_VAL, FDATE, FPRD, Name

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

-> R�� FIN_NAME, FIN_VAL, FDATE, FPRD�� A�� Name�� ���� ������ ���̺��� ��ȯ�϶�� ��
   - A�� I�� ID�� �������� ����
   - R�� I�� FIN_ID�� �������� ����
   - A�� ID�� �����ϴ� �����͸� ����

insert into @return_table

-> select���� �� �ټ��� �����͸� insert �϶�� ��
   �Է� �����Ͱ� �� �κп� select������ ��ȸ�ϴ� ������ ���� -> ��ȸ�� ����� ���̺� insert��
   ��ȸ ����� insert�� ������ Į���� ��ġ�ؾ� ��
*/

--�Լ� �����ϱ�
drop function f_info2

/*

�Լ�
 - SQL �����Լ� : ���ݱ��� ����� �Լ�
 - ����� �����Լ� : Scalar �Լ�(SUM�̳� AVGó�� ���� ��ȯ�ϴ� �Լ�), Tabel �Լ�

1. Scalar �Լ�

 create function<function_name>(       -> ���ϴ� �Լ� �̸�
 @<input_variable>                     -> ���� ���� �� �ִ� �Ű����� / �ʿ����� ������ ���� ����
 )
 returns<data_type>                    -> ��ȯ�Ǵ� ���� Ÿ��, data�� ����
 as
 begin
 <sql_query>
 return<return_value>
 end

2. ���̺��� ��ȯ�ϴ� �Լ� 1

 create function<function_name>(
 @<input_variable>
 )
 returns table
 as
 return(<return_tabel_query>)

3. ���̺��� ��ȯ�ϴ� �Լ� 2
 
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

 ->begin�� end ���̿� �پ��� ���α׷��� �۾��� �� �� �ִٴ� ����

4. �Լ��� ������ ����

���� : drop function <function_name>
���� : alter function <function_name>

*/
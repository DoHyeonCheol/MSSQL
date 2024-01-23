use study
go
select*from companyinfo

--employees �������� ���� �ű��
select name
, employees
, ROW_NUMBER() over (order by employees DESC) as ����
from companyinfo
order by ����

--ID��40853�� �Ｚ������ ����, ��������, ���������� �Ѳ����� �����ֱ�
select date_
, close_ as ����
, lag(close_,1) over (order by date_) as ��������
, lead(close_,1) over (order by date_) as ��������
from stockprice
where ID=40853
order by Date_

--lag, lead�Լ��� �̿��� ���ü��ͷ��� ���ϼ��ͷ� ���ϱ�
select date_
, close_/lag(close_,1)over(order by date_)-1 as ���ü��ͷ�
, lead(close_,1)over(order by date_)/close_ -1 as ���ϼ��ͷ�
from stockprice
where ID=40853
order by date_

--������ ����� ũ�⺰ ���� Ȯ���ϱ�
select name
, incinCtryCode
, rank()over(partition by IncInCtryCode order by Employees DESC) as ����
from companyinfo

--������ ����� ũ�⺰ ���� Ȯ���ϱ� (Null ���� ver)
select name
, incinCtryCode
, rank()over(partition by IncInCtryCode order by Employees DESC) as ����
from companyinfo
where IncInCtryCode is not null
order by ����

--ID�������� ���ͷ� ����ϱ�
select date_
, ID
, close_/lag(close_,1)over(partition by ID order by date_)-1.0 as ���ͷ�
from stockprice

--�ֽ� ���� �̵���� ���ϱ�
select date_
, ID
, close_
, avg(close_)
over(partition by ID
order by date_ rows between
2 PRECEDING and 0 PRECEDING) as SMA3
from stockprice

/*

partition by��
 - �������� ���� ���� ����ϴ� ����
 - ���� ���� �����͸� �ٷ� �� ���� Ȱ��
 - �����Լ�, �̵��Լ��� �Բ� ���� ���ȴ� 

�����Լ�
 - row_number() : �ߺ� ���� ����, ������ ���� �־ �ϴ� ������ �ű�� �Լ� (������ ���� ���� X)
 - rank() : �ߺ������� �����ϸ�, ���� ������ �ߺ� ���� ���� ���� ������ �Ǹ�, ������ ���� ��� ���� ���� 
 - dense_rank() : �ߺ� ���� �����ϸ�, ���� ������ �ߺ� ���� ���� �� +1�� ��
 (rank ���� ��� ���� 2���� 2���� ��� ���� ���� 4�� / dense ���� ��� ���� 2�� 2���̾ ���� ���� 3��)

���� �Լ� ����
select coulumns, �����Լ�()over(order by columns)
from table_name
where condition

�̵��Լ�
 - SQL Server������ 2012�� ���� �������� ��� ����
 - lag�� �������� ���� �����ö� ���
 - lead�� ���� ���� ���� ������ �� �����
   >> lag, lead �Լ��� ��ȭ���� ����� �� �ʼ������� ���
      * ��ȭ�� = (���簪-������)/������ = (���簪/������)-1

�̵��Լ� ����
select columns, lead(column1, offset)
over(order by columns)
from table_name
where condition
  >> offset ���� �� 1���� ��(��) ���� ��������, ���� ������ ��� ������ ����ŭ�� �����͸� ������

partition by
 - group by�� �����ϰ� � �׷쿡 �����ϴ� �Ԥ�
 - �׷��� ����� �ش� ���ڵ��� ������ ���캸�ų� �̵��Լ� ���� ������ �� ���

partition by ����
select function ()over(partition by columns[order by columns])  >partion by �ڿ� �ִ� columns�� ���� ������ �Ǵ� ��
from table_name
where condition
*/


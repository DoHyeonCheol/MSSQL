use study
go
select*from companyinfo


--�ֽİ��ݰ� ����� ������ �����ϱ�
select companyinfo.Name
, StockPrice.Date_
, StockPrice.Close_
from companyinfo
join StockPrice
on companyinfo.ID=StockPrice.ID

--�ֽİ��ݰ� ����� ������ �����ϱ� (ALIAS�� �̿��� �ڵ� ����ȭ�ϱ�)
select c.Name
, S.Date_
, S.close_
from companyinfo C
join StockPrice S
on C.ID=S.ID

--�� ���̺��� Left Join���� IND_ID �� �������� �����ϱ�
select C.Name
, C.IND_ID
, I.IND_Name
from companyinfo C
left join Industryinfo I
on C.IND_ID = I.IND_ID

--�� ���̺��� full outer join ���� IND_ID �� �������� �����ϱ�
select C.Name
, C.IND_ID
, I.IND_Name
from companyinfo C
full outer join Industryinfo I
on C.IND_ID = I.IND_ID

--���� ���̺��� join���� ��ø�ؼ� �����ϱ�
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

join�̶�?
 - SQL�� ���� ������ �������, SQL SELECT�� ������ �� �ִ� �ſ� �߿��� �۾�
 - �����ͺ��̽� �ȿ� ���� ���̺극 ���� ����Ǿ� �ִ� ���� > �ϳ��� �����ϴ� ���
   (Ư���� ������ ����� ���� ���̺��� ������ �ϳ��� ����� ��ȯ�ϴ� ��)

join ����
select column1, column2, ...
from table1_name join table2_name
on table1_name.columnA = table2_name.columnA
and table2_name.columnB = table2_name.columnB
...

�����ϰ��� �ϴ� �� ���̺��� ���� ���� ������ ���� ������ �־�� ��
������ ���̺��� join���� �����ϰ� �� ������ �Ǵ� ���� on���� ���� (�ϳ��� ��, ���� �� ��� �������� �� �� ����)

Join�� ����
 1. Inner JOin  (���ο��� ��κ��� �����ϹǷ� ��������)
  - �Ϲ����� join
  - �� ���̺� ��� �����ϴ� ���� �������� ����
 2. Left Join
  - ���� ���̺��� ��� ���ڵ�� �ϴ� �������� ��ġ�ϴ� ������ ���ڵ带 �ٿ���
  - ������ ���̺� �����Ͱ� ������ NULL�� ä��
 3. Right Join
  - left join�� ������ ������ ���̺� ������
 4. Full Outer Join
  - ������ ��� ���ڵ带 �������� ��ġ���� �ʴ� �κ��� null�� ä��

left join ����
select column1, column2, ...
from table1_name left join table2_name
on table1_name.columnA = table2_name.columnA
and table1_name.columnB = table2_name.columnB
...

right join ���� (�ǹ������� ����� �� ����)
select column1, column2, ...
from table1_name right join table2_name
on table1_name.columnA = table2_name.columnA
and table1_name.columnB = table2_name.columnB
...

full outer join ����
 - ��� ������ �δ� �� �����ϴ� ���
 - �� ���̺�� ���� �� �ִ� ��� ����� ���� ������ ���� ������ ã�� ������ ����
 - join�� left join, right join�� ����� ��� ��ģ ���

select column1, column2, ...
from table1_name full outer join join table2_name
on table1_name.columnA = table2_name.columnA
and table1_name.columnB = table2_name.columnB
...

join�� ��ø�ϴ� syntax
 - join�� ��� ��ø�ؼ� ����� �� ����
 -���� ��ü�� Ư���� �޶����°� ���� join�� �����ؼ� ����ϱ⸸ �ϸ� ��

����
select column1, column2, ...
from table1_name 
join table2_name
on table1_name.columnA = table2_name.columnA
and table1_name.columnB = table2_name.columnB
join table3_name
on table1_name.columnB = table2_name.columnC
...

join����
 - ������ �����ͺ��̽��� �ַ��� �ǵ��� ���� �ֿ�
 - ������ ���ݺ��� ���̺��� ���� �����ϰ� ��ĥ  ���� join�� ����Ͽ� ���ϴ� ���·� �����ִ� ����� RDB�� �ٽ�
   (RDB : ������ ���� ����, ���� ���� ���, ���� �˻�)

*/
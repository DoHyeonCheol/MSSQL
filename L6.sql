use study
go
select*from companyinfo

--���������� �̿��� ���ϴ� ������ ���͸��ϱ� (���� ���� ����� 2020.10.12 �ֽİ����� ��ȯ�ϱ� + �ֽİ����� 50���� �̻��� ����)
select seoul.name, seoul.close_
from
(select A.Name, S.Date_, S.close_
from companyinfo A
join StockPrice S
on A.ID = S.ID
where city = 'Seoul' and S.Date_ = '20201012'
)seoul
where close_>=500000

--���������� ���� ��ó�� ����ؼ� ������ ��������
select*
from stockprice
where id = 40853
and close_ = (select max(close_) from stockprice where id = 40853)

--���� �� �������� �־� ������ �ҷ�����
select name
from companyinfo
where ID IN
(SELECT ID
FROM StockPrice S
Group by ID
having max(close_)>=500000
)

--vw_stockpricewithname �̸��� view �����ϱ�
create view vw_stockpricewithname
as
select a.Name
, a.ID
, s.Date_
, s.close_
from companyinfo a
join stockprice s
on a.id = s.id


--view�� �̿��� �ڵ� �����
select*
from vw_stockpricewithname
where name = 'nvidia'
order by date_

--view �����ϱ�
drop view vw_stockpricewithname  -- �� �̻� ����� �� ����

--with�� �̿��� �������� ��Ȱ���ϱ�
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

��������

1. Nested Subquery : ���� ��
2. Inline Subquery : ���� �� ���̺�      -> 1,2,3 ��� ��ȣ�� ���� ����
3. Scalar Subquery : ���� �� ���

���������� �̿��ϴ� syntax
: ���� ���̺��� �����ϴ� ��ġ�� ���������� ����� �ϳ��� ���̺� ���°� �Ǹ� ����� �� ����

�⺻ ����
select SubQueryName.Column1, ubQueryName.Column2, ...
from (��������) SubQueryName

���� �� ������ ���������� �̿��ϴ� syntax
: ���� ���� ��ȯ�ѱ⿡ ���� Ȱ��Ǵ� ��� ��ġ�� ��ȣ ���·� �� �� ����

�⺻ ����
select(��������0), SubQueryName.column2, ...
from table_name1
where column1 = (��������1) or column2 >= (��������2) ...

���� �� ���̺�
 - ���� �ϳ��ۿ� ���� ���̺�
 - ���̺� ��ġ������ ����� �� ������ where �������� ����� �� ����
 - where �������� �ַ� in ������ �Բ� ���

in
 - �� Į���� ���� �� ���ǵ��� �ְ� ���� �� ���
 - �� Į���� ���Ͽ� or ������ �ʹ� ���� ���� �Ǵ� ��� �ڵ尡 ������������ ������ �� �ڵ�

ex) Į���� A�̰ų� B�̰ų� C �� �ϳ��̸� ��ȯ�ض�
or ��� : Į�� = A or Į�� = B or Į�� = C
in ��� : Į�� in (A, B, C)

�������� ��,����
 - ���� : �پ��� ��ġ���� ��� �����ϸ�, ���� �� ��ø�ؼ� ��� ������
 - ���� : ���������� �ʹ� �������� �ڵ尡 ����ġ�� �������� �б� ������� > �ڵ��� �������� ������
   -> ���� ����ϴ� ���������� �ϳ��� �������� ������ ���̺�ó�� ����ϵ��� �����ִ� view ���

View
 - �ϳ� �̻��� �⺻ ���̺�� ���� ������, �̸��� ������ ������ ���̺�
 - ������ġ ���� ���������� �������� ������ ����ڿ��� �ִ� ��ó�� ���
 - �ʿ��� �����͸� ��� �����ؼ� ó���� �� �ֱ⿡ ������ �����ϰ� ��ɹ��� ������

view�� �̿��ϴ� syntax
create view �� �̸�
as
select�� ����� ������

view�� �����ϴ� synrax
drop view �� �̸�

with ����
 - ���������� �����ϴ� ��� �� view ó�� create, drop ������ �ڵ带 �������� �ʰ� �� �� �ִ� ���
 - �ٸ� �ڵ忡���� �ݺ� ��뼺�� ���� ��� view���� with�� �� ����

with [����][(Į����[,Į����2])]as)
 sub query
)
[������ ����ϴ� main query]

*/
use study
go
select*from companyinfo

--ID�� 40853�� ȸ�� ã��
select*from companyinfo
where id=40853

--ID ���� 40853�� ����� �ְ�, �ּҰ�, ��հ��� �˾ƺ���
select max(close_) as �ְ�, min(close_) as �ּҰ�, avg(close_) as ��հ�
from stockprice
where id = 40853

--ID ���� 40853�� ����� �ְ�, �ּҰ�, ��հ��� �˾ƺ��� (as ���� ver.) - No column name���� ���
select max(close_), min(close_), avg(close_)
from stockprice
where id = 40853

--stockprice ���̺��� ����� ����� �ִ�, �ּ�, ���, �ŷ��ϼ� Ȯ���ϱ�
select max(close_) as �ְ�, min(close_) as �ּҰ�, avg(close_) as ��հ�, count(close_) as �ŷ��ϼ�
from stockprice
group by ID
order by �ŷ��ϼ�
--order by�� �ŷ��ϼ� ���� �������� ū ������ ����

--companyinfo ���̺��� ����� ���ø� �������� �� ����� �� ���� ����ߴ��� �˾ƺ���
select city
, sum(employees) as �����    -- ����� ����
, max(employees) as �ִ���  -- �ִ�� ����� ȸ���� ����� ��
, count(*) as ȸ���          -- ���ÿ� �����ϴ� ���� (���̺��� ��� ���� ����)
from companyinfo
group by city
order by ����� DESC 

--������� 200�� �� �̻��� ���� �˾ƺ���
select city
, sum(employees) as �����    
, max(employees) as �ִ���  
, count(*) as ȸ���          
from companyinfo
group by city
having sum(employees)>=2000000
order by ����� DESC 

/*

�����Լ� 
: ���� ����, �հ�, ��� ���� ����ϴ� �Լ��̸�, Ư�� �׷캰�� �� ��ġ�� �˾ƺ��� �� ���

ex) avg() : ���� ���
	--------------------------
    count() : ���� �� ����
	max() : ���� �ִ�                 ����, ��¥ ���������� ���� ����
	min() : ���� �ּڰ�
	--------------------------
	sum() : ���� �հ�
	stdev() : ǥ������

as : ������ ���� �̸��� ���̴� ���  >> ALIAS

group by ���� �̿��� �׷� �����
: �׷��� ������� select ������ group by ���� ���
 > SQL������ from ���� where �� �ڿ� ���� ����� �׷�ȭ

group by ����
select column_name(s)
from table_name
where condition
group by column_name(s)   - ����, ����, ȸ�� �� �׷��� ��Ȯ�� ���� �� ���� ���� ����� ����

having
: group by���� ���� ��� �߿��� ���ϴ� ���ǿ� �����ϴ� ����� ���� ���� �� �����
  ������ group by ���� �Բ� ���
  ������ where���� ��������� having �����Լ��� ������ ���͸��� �� ���
   > group by�� ���� ������ �׷��� ���� Ư���� ������ �ο��ؼ� ����� ��

having ����
select column_name(s)
from table_name
where condition
group by column_name(s)
having condition
*/
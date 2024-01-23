use study
go
select*from companyinfo
select name, city, IncInCtryCode from companyinfo
--�޸�(,)�ϳ��� ������ ������ ������ ��

--select�� distinct ������ �ߺ����� �ʰ� ���̺� ��ȯ�ϱ�
select distinct IncInCtryCode from companyinfo

--IncInCtryCode�� ���� KOR�� �����͸� ��������
select*from companyinfo where IncInCtryCode='kor'
--�ʵ� ���� �ؽ�Ʈ�� ��� ''�ְ�, ������ ��� �״�� ����ص� ���� ����

--Employees�� 10�� �̻��� ��� ���ڵ� ��������
select*from companyinfo where Employees>=100000  --���ǿ����� ��� ����

--IncInCtryCode ���� kor�̸鼭 Employees�� 5�� �̻��� ��� ���ڵ� ��������
select*
from companyinfo 
where IncInCtryCode='kor' and Employees>=50000

--city���� Seoul�̰ų� Busan�� ������ڵ� ��������
select*
from companyinfo 
where city='seoul' or city='busan'

--IncInCtryCode ���� USA�� �ƴ� ��� ��� ���ڵ� ��������
select*
from companyinfo 
where not IncInCtryCode='USA'

--IncInCtryCode ���� USA�� �ƴϰ� JPN�� �ƴ� ��� ���ڵ� ��������
select*
from companyinfo 
where not IncInCtryCode='USA' 
and not IncInCtryCode='JPN'

--'a'�� �����ϴ� ��� ��� ã��
select*from companyinfo where name like 'a%'

--'a'�� �����ϰ� �ڿ��� 4���� ���ڷ� �̷���� ��� ã��
select*from companyinfo where name like 'a____'

--�����ڵ��� ���ĺ� ������� �����ϱ�
select IncInCtryCode, Employees, name
from companyinfo
order by IncInCtryCode

--�����ڵ��� ���ĺ� ������� �����ϱ� (NULL ���� ver)
select IncInCtryCode, Employees, name
from companyinfo
where IncInCtryCode is not null
order by IncInCtryCode

--�����ڵ��� ���ĺ� ������� Eployees�� ū ������ ���� ������ �����ϱ� (NULL ���� ver)
select IncInCtryCode, Employees, name
from companyinfo
where IncInCtryCode is not null
order by IncInCtryCode, Employees DESC


/*
use 
�ڿ� ��ü���� DB�� �������� ���� ��� RDBMS�� �α��ε� ù ���� ����� master �����ͺ��̽��� �����͸� ��û

go
������ �ڵ带 ���� �� ���� �ڵ带 �����϶�� ������
���� �۾��� �� �ڵ忡�� �����ų �� �۾����� �������ֱ� ���� ���

use�� ������� �ʴ� ���
select*from study.dbo.companyinfo �� �Է�

dbo�� database owner�� ���ڷ� ���� 99%�� dbo�̹Ƿ� ��ħǥ(.)�� �Է���

���� �ڵ带 ������ ���� ������� ǥ���� �� ���� selcet*from study..companyinfo

select��
: �����ͺ��̽����� �����͸� �������� �� ��� (������� ���̺� ����)

ex)   select column1, column2, ...
      from table_name

���� ��� ���̺��� �������� �ʹٸ� select*from table_name ���

distinct �ڵ�
: ���� �ٸ� ������ ��ȯ�� �� ������ �ߺ��Ǵ� ���� �ϳ��� �����ִ� distinct �ڵ�

ex)   selcet distinct column1, column2, ...
      from table_name

where�ڵ�
: ����� ���� �����Ͱ� ��� �ִ� �����ͺ��̽� ���̺� (Ư�� �뵵�� �´� ���븸 ������ �۾��̳� ���� ���)
  ���ϴ� �����͸� ��������, ���ǿ����ڸ� ����� �� ����

ex)   select column1, column2, ...
      from table_name
	  where condition     (condition�� ����)

���� ������
and : �� �� �����ϴ� ���ڵ带 ��ȯ
or : �� �� �ϳ��� �����ϴ� ���ڵ带 ��ȯ
not : �ش� ������ �������� �ʴ� ���ڵ带 ��ȯ

and ����
select column1, column2, ...
from table_name
where condtion1 and condition2....

or ����
select column1, column2, ...
from table_name
where condtion1 or condition2....

not ����
select column1, column2, ...
from table_name
where not condtion1

like ������
: ��Ȯ�� Ư���� ������ ������ ���� ã�� �� ���
  ex) �� �̸��� ���ĺ� "P"�� ���Ե� ������ ã�� ��
      ��� �̸� �߰��� BIO���� ������ �ִ� ����� ã�� ��

like ����
select column1, column2, ...
from table_name
where condition like pattern

���ϵ�ī��
: ������ �����ϱ� ���� ���Ǵ� Ư�� ���� (%, _ �� �ַ� �����)
  % : ��� ���ڿ� �ǹ�
  _ : �� ���ڸ� �ǹ�
�ٸ� �˻��� ���� ���� �ð��� �ɷ� ������ ���� ��ų �� �����Ƿ� �ݵ�� �ʿ��� ��찡 �ƴ� ���
�˻� ������ ���� �κп��� ���� �ʴ� ���� ����

������ �����ϱ�

order by�� �̿��� ���ϴ´�� �����͸� �����ϱ�
�������� ������ desc, �������� ������ asc
�ʵ尡 ���ڸ� ������ ũ�⿡ ������ ���ڸ� ���ĺ� ������ ����

order by ����
select column1, column2, ...
from table_name
order by column1, column2, ... desc     �⺻�� ���������̱⿡ asc�� �Է����� �ʾƵ� asc�� ����

*/


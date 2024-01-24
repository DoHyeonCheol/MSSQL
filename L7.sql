use study
go
select*from companyinfo

--employees�� �����Լ� �����ϱ�
select sum(employees) as �հ�
, avg(employees) as ���
, max(employees) as �ִ�
, min(employees) as �ּ�
, count(employees) as ����
from companyinfo

--���ڿ� �Լ� �����ϱ�
print len(' Abc Def Fed CBa ')                        --���ڿ� ���� ��ȯ
print ltrim(' Abc Def Fed CBa ')                      --���� ���� ����
print rtrim(' Abc Def Fed CBa ')                      --���� ���� ����
print upper(' Abc Def Fed CBa ')                      --��� ���ڸ� �빮�ڷ� ǥ��
print lower(' Abc Def Fed CBa ')                      --��� ���ڸ� �ҹ��ڷ� ǥ�� 
print left(' Abc Def Fed CBa ', 6)                    --���ʿ��� 6�� ���
print right(' Abc Def Fed CBa ', 6)                   --�����ʿ��� 6�� ��� 
print reverse(' Abc Def Fed CBa ')                    --�Ųٷ� ���
print replace(' Abc Def Fed CBa ', 'Abc', 'ZZZ')      --Ư�� ������ ã�Ƽ� ������ ġȯ
print replicate('HI', 10)                             --Ư�� ���ڿ� �ݺ�
print'['+space(10)+']'                                --������ ������ ���
print str(12345) + '6789'                             --�������� ���ڿ��� ��ȯ
print substring(' Abc Def Fed CBa ', 6, 3)            --���ڿ� �˻� : ��𼭺��� �� �� �˻�
print charindex('Def', ' Abc Def Fed CBa ')           --Ư�� ���ڿ��� ��ġ�� �˻�

--��¥ �Լ� �����ϱ�
print getdate()                                       --���縦 ��ȯ
print year(getdate())                                 --�⵵�� ��ȯ
print month(getdate())                                --���� ��ȯ
print day(getdate())                                  --��¥�� ��ȯ
print datediff(day,getdate(), '2012-12-25')           --�� ��¥ ���� ���̸� ��ȯ
print dateadd(month, 3, getdate())                    --��¥�� ����

--���� 2020�� '��'��  �����ϴ� �ڵ� �����
print cast(2020 as varchar) + N'��'
print convert(varchar, 2020) + N'��'
-- > ���� �տ� N�� ���̴� ���� : �����ڵ����� �˷��ֱ� ����
-- >                            N ������ SSMS�� ���ڿ��� �ν����� ���� 2020???�� ��ȯ

--��¥�� ���ڿ��� ��ȯ�ϴ� �ڵ� �����
print cast(getdate() as varchar)
print convert(varchar(8), getdate(), 112)
--> cast�� ��°��� �ܼ��� ���ڿ��� �ٲٴ� �ݸ�, convert�� ��¥�� ����� ���·� ��ȯ


/*

�������� Ÿ��

��� ���̺��� ���� ���� ������ Ÿ���� ����
 ex) ����, �Ǽ�, ����, ��¥, �̹���, ���̳ʸ�, xml
���� ����ϴ� ���̺� �����ϴ� ������ ������ Ÿ���� �˾ƾ� �����͸� ��� ó���ؾ� �ϴ��� �� �� ����

1. ���� ����

������ Ÿ��            ����                 ������ ũ��
char(n)            ���� ���ڿ�           �ִ� 8,000����
varchar(n)         ���� ���ڿ�           �ִ� 8,000����
varchar(max)       ���� ���ڿ�           �ִ� 1,073,741,824����
nchar           ���� �����ڵ� ���ڿ�     �ִ� 4,000����
nvarchar(n)     ���� �����ڵ� ���ڿ�     �ִ� 4,000����
nvarchar(max)   ���� �����ڵ� ���ڿ�     �ִ� 536,879,912����

(�տ� n�� ���� ������ ��� �ƴ� �ٸ� ���� �� �����ϱ� ���ؼ�)

2. ���� ����

������ Ÿ��                  ����                    ������ ũ��
tinyint                    0 ~ 255                   1����Ʈ
smallint             -32,768 ~ 32,767                2����Ʈ
int           -2,147,483,648 ~ 2,147,483,647         4����Ʈ
bigint                 -2^63 ~ 2^63-1                8����Ʈ 
decimal(p,s)        -10^38+1 ~ 10^38-1             5~17����Ʈ           (p�� �ڸ���, s�� �Ҽ����ڸ� ��)
numeric(p,s)        decomal�� ��ɻ� ����           5~17����Ʈ  
smallmoney             -21�� ~ 21�� ȭ��              4����Ʈ
money                -2^63 ~ 2^63-1 ȭ��              8����Ʈ
float           -1.79E+308 ~ 1.79E+308 �Ǽ�          4~8����Ʈ
real             -3.40E+38 ~ 3.40E+38 �Ǽ�            4����Ʈ


3. ��¥Ÿ��

������ Ÿ��                        ����                        ������ ũ��
datetime               1753-1-1 ~ 9999-12-31, 3.33ms            8����Ʈ
datetime2              0001-1-1 ~ 9999-12-31, 100ns            6~8����Ʈ
smalldatetime           1900-1-1 ~ 2079-6-6, 1min               4����Ʈ
date                   0001-1-1 ~ 9999-12-31, 1day              3����Ʈ
time                    100ns���� ��¥ ���� �ð���              3~5����Ʈ

�����Լ� ����

sum (�հ�) / avg (���) / max (�ִ�) / min (�ּ�) / count (����)

���ڿ� ���� �Լ�

substring(���ڿ�, p, n) : ���ڿ��� p ��ġ���� n���� ���ڵ��� ��ȯ�ϰ� ��
replace(���ڿ�, pattern, new) : ���ڿ����� pattern�� ��ġ�ϴ� �κ��� new�� �ٲ�
charindex(pattern, ���ڿ�) : pattern�� ���ڿ��� ��� ��ġ�ϴ��� ��ȯ��

��¥ ���� �Լ�

getdate() : ������ ��¥�� �ð��� datetime �������� ��ȯ
year/month/day(getdate()) : ���� �̸��� ���ϴ� ��ó�� ������ �⵵, ��, ��¥�� ��ȯ 
datediff(year/month/day(getdate(), '�� �� �� ��') : �� ��¥ ���� ���̸� ��ȯ
dateadd(year/month/day, ����, getdate()) : �־��� ���ڸ�ŭ �⵵, ��, ��¥�� ����

���� ��ȯ �Լ�

cast 
 - ���ڿ��� ���ڷ� �ٲ�         ex) "1111" -> 1111 (�ݴ뵵 ����)
 - �⺻���� �� ��ȭ �۾� ����   ex) 10 19 2020 4:41PM -> 20201019 
convert
 - ����ڰ� ���ϴ� ������ �����ͷ� ��ȯ    ex) 234���� -> "234" + "����"
 - �߰� �Ķ���Ϳ� ���� ���� �ʿ�
cast�� convert�� ��ȯ�ϴ� �ڵ��� ����� �ٸ��� ���� �۾��� ����

*/
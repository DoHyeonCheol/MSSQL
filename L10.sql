--SP_select_companyinfo��� ���ν��� �����

use study
go
create procedure SP_select_companyinfo
as
begin

select*from companyinfo
end

--������ ���ν��� SP_select_companyinfo�� �����ϱ�

exec SP_select_companyinfo

--����ڵ�� �Ⱓ�� �Է� �޾� �ش� �Ⱓ ������ ����� ������ ����ϴ� ���ν��� �����
create proc SP_SELECT_STOCKPRICE @ID int, @StartDate Date, @EndDate Date
as
begin

select Date_, Close_
from StockPrice
where ID=@ID
and DATE_ between @StartDate and @EndDate
order by DATE_ DESC
end
go
exec SP_SELECT_STOCKPRICE 40853, '2020-10-01', '2020-10-13'

/*
�ڵ� ����

create proc SP_SELECT_STOCKPRICE @ID int, @StartDate Date, @EndDate Date

-> ����ڵ�, ���� ��¥, ������ ��¥�� �ǹ�

and DATE_ between @StartDate and @EndDate

-> ���� ��¥�� ������ ��¥ ������ ������ ��������� ��
*/

--������ ���ν��� �����ϱ�
drop procedure SP_select_companyinfo
drop procedure SP_SELECT_STOCKPRICE

--if���� �̿��� ����� ������ ¦������ Ȧ������ �˷��ִ� �ڵ� �ۼ��ϱ�
DECLARE @I INT = 110
IF @I%2 = 0
BEGIN
PRINT N'¦��'
END
ELSE
BEGIN
PRINT N'Ȧ��'
END

--while ���� �̿��� 1���� 100������ ���� ���ϴ� �ڵ� �ۼ��ϱ�
DECLARE @I INT = 1
DECLARE @ADDED BIGINT = 0
WHILE (@I <=100)
BEGIN
SET @ADDED = @ADDED + @I
SET @I = @I+1
END
PRINT @ADDED

/*
�ڵ� ����
������ @I�� 1��
@ADDED�� 1 ���� 100���� ������ ����� ����� ����
WHILE�� : @I���� 100���� ���� ��� ��� �����Ѵٴ� ��

��, @I�� 100�� �Ѿ�� ������ WHILE���� ������ ��� ����Ǹ� @I�� @ADDED�� ����
@I�� 101�� �Ǵ� ���� WHILE ������ �������� �׵��� @I ���� �������� ��� ���ŵǾ��� @ADDED�� ���� �� ���
*/


--while���� contibue�� break�� �־� �ڵ带 �ۼ��ϱ�
DECLARE @I INT = 1
DECLARE @ADDED BIGINT = 0
WHILE (@I <=100)
BEGIN
IF @I%9 = 0
BEGIN
PRINT CAST(@I AS VARCHAR) + N' : 9�� ����Դϴ�.'
SET @I = @I + 1
CONTINUE
END
IF @ADDED >=3000
BEGIN
PRINT N'@ADDED��' + CAST(@ADDED AS VARCHAR) + N' ���� �Ǿ� �����մϴ�.'
BREAK
END
SET @ADDED = @ADDED + @I
SET @I = @I +1
END

--���̺��� �̸��� �Ű������� �޾� �ش� ���̺��� �����͸� ������ִ� ���ν��� �ۼ��ϱ�
CREATE PROC SP_SELECT_TABLE_INFO @TableName Varchar(3000)         --> �Էº��� : ���̺��
AS  
BEGIN
   DECLARE @sqlQuery varchar(3000)
   SET @sqlQuery = 'SELECT*FROM ' + @TableName       --> ���ڿ� ������ ���� ����

   EXEC(@sqlQuery)                                   --> ���ڿ��� �� ���� ����

END
GO

exec SP_SELECT_TABLE_INFO 'StockPrice'
exec SP_SELECT_TABLE_INFO 'Companyinfo'


/*

1. ���� ���ν��� (stored procedure)
 -SQL���� �����ϴ� ���α׷��� ���
 -�Լ����� ������ ���� ���� -> ������ ����Ͻ� ������ ���� �� ������, ������ ó���� ������ ���� ����

���� ���ν����� ����� ���
create procedure <procedure name>
@<parameters>
as
begin
<sql_query>      -> �����ڰ� ������ �Է��ϴ��Ŀ� ���� �������� �ܼ����� �޷� ����
end

-> DB - ���α׷��� - ���ν����� ������

2. �Ű������� �ִ� ���ν���
  -���ν����� �Լ��� ���� �Ű������� �޾� ó���� �ܺη� ����� ������ �� ���� -> ������, ��ȣ�� ������� ����

3. ���ν����� ���� �� ����

- ���ν����� �����ϴ� ���
alter procedure<procedure name>
@<parameters>
as
begin
<sql_query>
end

- ���ν����� �����ϴ� ���
drop procedure<procedure name>

4. ����� �ݺ���

if��
������ ������ �� �����ϸ� �Ҹ��� �� ������

if else��
������ ������ �� �����ϸ� �Ҹ��� �� ������
 -> begin...end�� ���������� ������� �ϸ�, begin�� end ������ ������ �����ϴ� ����
 -> �׷��� ���� ���, ù���常 ����ǰų� ���� ��ȯ

if<���ǹ�>
  begin
    <sql_query1>
  end
else
  begin
    <sql_query2>
  end

--> if�� ���� ������ true�� sql_query1�� �����ϰ�, �ƴϸ� sql_query2�� ����

while��
-SQL���� ������ �����ϴ� �� ��� �ݺ� ������ �ϴ� ����
-while ������ ���� SQL���� ������ ������ �����Ǵ� �� �ݺ������� ����
-while ���� ���� SQL�� ������ break�� continue Ű���带 ����Ͽ� ����

while<���ǹ�>
begin
  <sql_query1>
  <sql_query2 | break | continue>
end

continue�� break�� �ַ� if���� �Բ� ���
continue : ������ ��� �����϶�� �ǹ̷� �Ʒ� �κп� ��ġ�� �ڵ���� �������� �ʰ� �ٷ� while ������ ó������ ���ư����� �۵�
break : �ش� ������ �������� ����


���� SQL
�ڵ带 ���ڿ��� ���� ���� �� ���ڿ��� �����Ű�� ���
 ex) "select*from companyinfo"��� ���ڿ��� � ���ڿ� ������ �����Ų ���� �� ���ڿ��� �����Ű�� ��

SELECT*FROM STUDY.CBO.COMPANYINFO
EXEC('SELECT*FROM STUDY.DBO.COMPANYINFO)  -> �� �ڵ�� ���� ���� ������� ��ȯ��

�Ű������� ���̺� ���� �޾� �ش� ���̺��� ���� ����ϰ� ���� ��� �����
���� SQL ������ ���� �پ��� ������ ������ �� �ִٴ� ������ ����

*/
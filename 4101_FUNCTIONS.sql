/*2� �� ������������� ������������ ��������� �� �����
TABLEEXISTS ��� �� ������� �� ��������� ��� ������ ����
��������� ��� �� ���������� ���� 0 �� �� ������� ��� ������� ���
���������� � �� ���������� ���� 1 �� �� ������� �������.*/

create or replace function TABLEEXISTS (table_number IN NUMBER) 
return number
AS
-- ������ ���������� �������
-- �� ������� ������ ��� ���������� �� ������ ���� ������ RestTable.
cursor SEARCHTABLE_CURSOR is
select table_number from RestTable WHERE table_number=notable;
--������ ���������� ��������
SEARCHTABLE_REC SEARCHTABLE_CURSOR%ROWTYPE;
-- ������ ���������� ���������� �����
TABLEVAL NUMBER;
BEGIN 
  -- �������� �������
  OPEN SEARCHTABLE_CURSOR;
  -- �� �� ������� ������ ��� ���������� ���� ���� 0 ��� ��������� RETVAL ������ ���� ���� -1
  FETCH SEARCHTABLE_CURSOR INTO SEARCHTABLE_REC;
  IF ( SEARCHTABLE_CURSOR%FOUND = TRUE ) THEN
  TABLEVAL:= 1;
  ELSE
  TABLEVAL:= 0;
  END IF;
  -- ������ �������
  CLOSE SEARCHTABLE_CURSOR;
  -- ��������� ��� ���� ��� ���������� RETVAL
 RETURN TABLEVAL;
END TABLEEXISTS;
/


/*2� �� ������������� ������������ ��������� �� ����� TABLERESERVED  ��� �� ������� �� ��������� ��� 
������ ���� ��������� ��� �� ���������� ���� 0 �� �� ������� ��� ����� ��������� � ���� clientID
(� ������� ��� ������ ��� �� ���� ��������) �� �� ������� ����� ��������� ��� ������� ������ ���
�������� � ���������. �� ��������� ��� �� ������� ��� ������ ��� ���������� �� ���������� -1 ���� 
��� ������ ���� �� �������������� � ����������� ���������.*/

create or replace function TABLERESERVED (table_number IN NUMBER) 
return number
AS
-- ������ ���������� �������
-- �� ������� ������ ��� ���������� �� ������ ���� ������ RestTable.
cursor SEARCHTABLE_CURSOR is
select * from RestTable WHERE table_number=notable;
-- ������ ���������� ��������
SEARCHTABLE_REC SEARCHTABLE_CURSOR%ROWTYPE;
-- ������ ���������� ���������� �����
TABLEVAL NUMBER;

--�� ������� ����� ��������� ��� ������ ���� ������ RecordBook �� ��� ���������� ��� ������ � �������
cursor SEARCHRES_CURSOR is
select DateIn,idrest from RecordBook WHERE table_number=nu_table;
--and DateIn = TO_CHAR(SYSDATE,'DD/MM/YYYY HH-MI-SS');
-- ������ ���������� ��������
SEARCHRES_REC SEARCHRES_CURSOR%ROWTYPE;
-- ������ ���������� ���������� �����
RESVAL NUMBER;
CLL NUMBER;

BEGIN 
  -- �������� �������
  OPEN SEARCHTABLE_CURSOR;
  -- �������� �������
  OPEN SEARCHRES_CURSOR;
  -- �� �� ������� ������ ��� ���������� ���� ���� 0 � ���� ��� ������ ������ ��� ��������� TABLEVAL ������ ���� ���� -1
  FETCH SEARCHTABLE_CURSOR INTO SEARCHTABLE_REC;
  IF ( SEARCHTABLE_CURSOR%FOUND = TRUE ) THEN
  -- �� �� ������� ��� ����� ��������� ���� ���� 0 ��� ��������� RESVAL ������ ��������� ��� ������ ��� ������ ��� �� ���� ���������
  FETCH SEARCHRES_CURSOR INTO SEARCHRES_REC;
  IF (SEARCHRES_CURSOR%FOUND = TRUE) THEN 
  IF (TO_CHAR(SEARCHRES_REC.DateIn ,'DD-MM-YYYY HH-MI-SS')=TO_CHAR(SYSDATE,'DD-MM-YYYY HH-MI-SS')) THEN 
  CLL:= SEARCHRES_REC.idrest;
  END IF;
  ELSE
  RESVAL:= 0;
  END IF; 
  RETURN RESVAL;
  CLOSE SEARCHRES_CURSOR;
  RETURN CLL;
  ELSE
  TABLEVAL:= -1;
  END IF;
  --������ �������
  CLOSE SEARCHTABLE_CURSOR;
  --��������� ��� ���� ��� ���������� RETVAL
 RETURN TABLEVAL; 
END;
/


/*2� �� ������������� ������������ ��������� �� ����� CALCULATEBILL ��� �� ������� �� ����������� ��� ������ ���� ���������� 
��������� ��� ��� ������ ��� ������ ��� �� ���� �������� ��� �� ���������� �� ������ ��� ������ �� �������� � �������. 
��� �� ��� ���������� ��� ��������� ������� �� ������ ����� �� ���� ��� ����������� ���� ��������� ��� ��������� ��� �� ����
��� ���������� �� ���� ��� ������� ��� ���������.�� � ������� ��� �� ���� �������� � ��������� �� ���������� -1.  */

--create or replace function CALCULATEBILL ( table_number IN NUMBER ,  id_rest IN NUMBER ) 
--return number
--AS
---- ������ ���������� �������� �������
--SERVNAME TABLE_SERV.SERVICE_TABLE%TYPE:=NULL; 
---- ������ ���������� ����� �������
--SERVCOST SERVICES.PRICE%TYPE:=NULL;
--
---- ������ ��������� �� ����� ��������� ,����� ��������� ��� ������ ���� ������ RecordBook �� ��� ���������� ��� ������ � �������
---- ������ ���������� �������
--cursor SEARCHRES_CURSOR is
--select DateIn,idrest from RecordBook WHERE table_number=nu_table and DateIn = TO_CHAR(SYSDATE,'DD/MM/YYYY HH-MI-SS');
---- ������ ���������� ��������
--SEARCHRES_REC SEARCHRES_CURSOR%ROWTYPE;
---- ������ ���������� ���������� �����
--RESVAL NUMBER;
--
----������ ���������� �������
----�� ������� ��� ���� �� ������� ��������� ���� ������ Table_Serv.
--cursor SEARCHSERV_CURSOR is
--select service_table from Table_Serv WHERE table_number = table_num;
----������ ���������� ��������
--SEARCHSERV_REC SEARCHSERV_CURSOR%ROWTYPE;
--
----������ ���������� �������
----�� ������ ��� ������� ������� ��� ����� price ��� ������ Services
--cursor SEARCHSERVCOST_CURSOR is
--select price from Services WHERE catServ = SERVNAME;
----������ ���������� �������� ��� �������� �������
--SEARCHSERVCOST_REC SEARCHSERVCOST_CURSOR%ROWTYPE; 
--
----������ ���������� �������
----�� ������ ��� ���������� ��� ��������� ������� ��� ����� minprice ��� ������ CategoryTable 
--cursor SEARCHCAT_CURSOR is
--select minprice from CategoryTable WHERE tableCat.CategoryTable=cat.RestTable;
----������ ���������� �������� ��� �������� �������
--SEARCHSERVCOST_CAT SEARCHCAT_CURSOR%ROWTYPE; 
--
--TOTALCOST NUMBER(4,1) := 0;
--
--BEGIN 
--
--OPEN SEARCHRES_CURSOR;
--OPEN SEARCHSERV_CURSOR;
--OPEN SEARCHSERVCOST_CURSOR; 
--
--FETCH SEARCHRES_CURSOR INTO SEARCHRES_REC;
--  -- ��� ���� ��� ������ ��� ������ �� ��� ������������� �������� ���� ������� ��� ������ ��� ��������� ��� ��������� ��� �� ������ ��� ����.
--  IF (SEARCHRES_CURSOR%FOUND = TRUE) THEN 
--  -- ���� ���� ��� ������� ��� ���� �� ������� �� ������ table_num
--  -- ��� ���� ������ ���� �� ����� ��� ��� ��������� SERVNAME 
--  FETCH SEARCHSERV_CURSOR INTO SEARCHSERV_REC;
--  WHILE ( SEARCHSERV_CURSOR%FOUND = TRUE ) LOOP
--  SERVNAME:= SEARCHSERV_REC.SERVICE_TABLE;
--  -- ��� ���� ������ ��� ���� �� ������� ���� ���� ��������
--  -- ��� ����� ��� ��������� SEVCOST 
--  FETCH SEARCHSERVCOST_CURSOR INTO SEARCHSERVCOST_REC;
--  IF ( SEARCHSERVCOST_CURSOR%FOUND = TRUE ) THEN
--  SERVCOST:=SEARCHSERVCOST_REC.price;
--  END IF;
--  END LOOP;
--  ELSE
--  RESVAL:= -1;
--  END IF; 
--  RETURN RESVAL;
--  --������ �������
--  CLOSE SEARCHSERV_CURSOR;
--  CLOSE SEARCHRES_CURSOR;
--  CLOSE SEARCHDVDCOST_CURSOR;
--  RETURN TOTALCOST;
--END;


/*2� N� ������������� ������������ ��������� �� ����� CLIENTMONEYPAIDYEAR �� ����������� ������ ������, ���� ���
�� ���������� ���� ������� �������� ���� �������� � ������� ��� ���������� ��� �� ���� ��� ����������. */

--create or replace function CLIENTMONEYPAIDYEAR (id_rest IN NUMBER,yearno IN YEAR)
--return number
--AS
--TOTALCOST NUMBER(5,1) :=0;
--BEGIN
--
--END;
--/ 

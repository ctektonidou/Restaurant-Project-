/*3� �� ������������� �� ����������� triggers ��� ��
������������ ��� ��� �� ������������� �������� ����� �������
������� ��� ������� �� ����� ������������ ��� ����
��������� �� �������� ��������. */

create or replace trigger CAPITALCUSTTRIGGER
before INSERT or UPDATE on Customer
FOR EACH ROW
BEGIN
 --������ ��� ���� ���:NEW.idrest,:NEW.id,:NEW.Lname,:NEW.Fname,:NEW.regDate,:NEW.afm ��������������� �� ��������� UPPER ��� SQL
 :NEW.idrest := UPPER( :NEW.idrest );
 :NEW.id := UPPER( :NEW.id );
 :NEW.Lname := UPPER( :NEW.Lname );
 :NEW.Fname := UPPER( :NEW.Fname );
 :NEW.regDate := UPPER( :NEW.regDate );
 :NEW.Afm := UPPER( :NEW.Afm );
END;
/ 


create or replace trigger CAPITALSERVTRIGGER
before INSERT or UPDATE on Services
FOR EACH ROW
BEGIN
 --������ ��� ���� ���:NEW.catServ,:NEW.price ��������������� �� ��������� UPPER ��� SQL
 :NEW.catServ := UPPER( :NEW.catServ );
 :NEW.price := UPPER( :NEW.price );
END;
/ 


/*3� ��� ������ ������������ ��� ����� �� ������������ trigger ��� �� ����������� ��� � ��� ����������� �� ��� ������� �� ����� 
 ����������. �� �������� ��������� �� ����������� ��� �� transaction �� ���������� �������� ��������� (user defined) */
 
create or replace trigger HOURTRIGGER
before INSERT or UPDATE on RecordBook
FOR EACH ROW
DECLARE
 HOUREXCEPTION EXCEPTION;
-- ������ ���������� ��� �� ���������� ��� ���� ��� ��� 
HOURATDAY CHAR(13); 
BEGIN
--���� ��� ������ ���� ��� ��������� �����������
 HOURATDAY:= TO_CHAR(SYSDATE,'DD-MM-YYYY HH'); 
 IF (HOURATDAY > TO_CHAR(:NEW.DateIn,'DD-MM-YYYY HH')) THEN
    RAISE HOUREXCEPTION;
 END IF; 
EXCEPTION 
WHEN HOUREXCEPTION THEN
    RAISE_APPLICATION_ERROR(-20001,'Access denied ,hour is not in the future');
END;
/


/*3� ��� ������ ��������� �� ������������ trigger ��� �� ��������� ��� �������� ���� ������ ��������� -���� ������ 
��������� ���� ����������� �����. */

create or replace trigger MONTHTRIGGER
before INSERT or UPDATE on RecordBook
FOR EACH ROW
DECLARE
-- ������ ���������� ���������� ���������� ����
MONTHEXCEPTION EXCEPTION;
-- ������ ���������� ��� �� ���������� ��� ������ ��� ����(0-11)
MONTHOFYEAR NUMBER; 
-- ������ �������� ����������
JANUARY CONSTANT NUMBER :=1; 
FEBRUARY CONSTANT NUMBER :=2; 
DECEMBER CONSTANT NUMBER :=12; 
 -- ������ ���������� ��� �� ���������� ��� ����� ��� ���� �� ���� , ����� ��� �� ����� ��� ����� 'MM' �.�. '31/12/2020'
 TODAY CHAR(2); 
BEGIN
--���� ��� ������ ���� ��� ��������� �����������
 --�� ����� ���������� ��������� �������� 
 MONTHOFYEAR:= TO_NUMBER(TO_CHAR(:NEW.DateIn,'MM'));
 IF MONTHOFYEAR = JANUARY THEN
 RAISE MONTHEXCEPTION;
 END IF;
 IF MONTHOFYEAR = FEBRUARY THEN
 RAISE MONTHEXCEPTION;
 END IF;
 IF MONTHOFYEAR = DECEMBER THEN
 RAISE MONTHEXCEPTION;
 END IF;
EXCEPTION
--�� �������� �������� MONTHEXCEPTION �������� ��� RAISE_APPLICATION_ERROR ��� ������� ��� ������������ ��� ��� transaction ��� 
--����� �������� ����� ��� ����� � trigger
WHEN MONTHEXCEPTION THEN
 RAISE_APPLICATION_ERROR(-20001,'Access denied on this month,its winter, try to book a table again in spring'); 
END;


/*3� �� �������������� ������������ �� ������ �� ������������ ��� �����������: 

i. ��� �������������� ������ ��� ������ ��������� ���� ��� �������� � �������� ���� ������� ��� ��� ������ ���������.
� ������������ �� ���� ����� TABLEBOOKTIMESTRIGGER.- noBook*/

create or replace trigger TABLEBOOKTIMESTRIGGER
before INSERT or DELETE on RecordBook
FOR EACH ROW
BEGIN
 IF INSERTING THEN --��������� �� 'IF INSERTING = TRUE THEN'
    UPDATE RestTable SET noBook=NVL(noBook,0)+1 WHERE notable=:NEW.nu_table;
 END IF;
 IF DELETING THEN
    UPDATE RestTable SET  noBook= noBook -1 WHERE notable=:OLD.nu_table;
 END IF;
END;
/ 


/*3�
ii. ��� �������������� ������ ��� ������ ���������� ���� ��� �������� � �������� ���� ������� ��� 
��� ������ ���������. � ������������ �� ���� ����� CATEGORYTABLESCOUNTTRIGGER.- num_of_table */

create or replace trigger CATEGORYTABLESCOUNTTRIGGER
before INSERT or DELETE on RestTable
FOR EACH ROW
BEGIN
 IF INSERTING THEN --��������� �� 'IF INSERTING = TRUE THEN'
 UPDATE CategoryTable SET num_of_table=NVL(num_of_table,0)+1 WHERE tableCat=:NEW.cat;
 END IF;
 IF DELETING THEN
 UPDATE CategoryTable SET  num_of_table= num_of_table -1 WHERE tableCat=:OLD.cat;
 END IF;
END;
/ 


/*3�
iii. ��� �������������� ������ ����������� ��� ������ ��������� ���� ��� �������� ���� ��������. � ������������ �� 
���� ����� RESERVATIONBILLTRIGGER. ��� �� ����������� �� ���� � ������������ �� ������ �� ������� ��� ������������ ���������
CALCULATEBILL.- bill*/
--
--create or replace trigger RESERVATIONBILLTRIGGER
--before INSERT or DELETE on RecordBook
--FOR EACH ROW
--BEGIN
-- IF INSERTING THEN --��������� �� 'IF INSERTING = TRUE THEN'
--    UPDATE RecordBook SET num_of_table=NVL(num_of_table,0)+1 WHERE tableCat=:NEW.cat;
-- END IF;
-- IF DELETING THEN
--    UPDATE CategoryTable SET  num_of_table= num_of_table -1 WHERE tableCat=:OLD.cat;
-- END IF;
--END;
--/ 


/*1� �� ������������� ������������ ���������� �� �����
BOOKTABLE, �� ����������� ������ ������, ������ ���������,
���������� ����������� ��� �� ��������� ��� ������� ����
������ ���������. �������� �� ������������ ��� � �������
��� ��������-�� ����� ���������� (SEQUENCE)*/

CREATE OR REPLACE PROCEDURE BOOKTABLE (id_rest IN NUMBER,nu_Table IN NUMBER,Date_In IN DATE)
IS
BEGIN
    INSERT INTO RecordBook (DateIn,DateOut,idrest,bill,nu_table,reservationNo)
    VALUES (Date_In,Date_In,id_rest,NULL,nu_Table,reservationNo.NEXTVAL);
END BOOKTABLE;
/


/*1� �� ������������� ������������ ���������� �� �����
ADDPHONE, �� ����������� ������ ������ ��� �������� ���
�� ����� ��� ���������� ���� ������ ���������. � ����������
�� ������ �� ������ ���� �������� ���� ��� � ������� ��� ��
�������� ��� ��� �������� �� ����� �� ������ ���� �
���������� �� �������� user defined exception � ���� �� ���
��������� � �������� ���� ���������.*/

CREATE OR REPLACE PROCEDURE ADDPHONE (id_rest IN NUMBER,n_phone IN NUMBER) 
IS
cursor SEARCHCUST_CURSOR is
    select COUNT(*) AS CUSTOMERPHONES from Phone WHERE id_rest=idrest;
     --������ ���������� ��������
    SEARCHCUST_REC SEARCHCUST_CURSOR%ROWTYPE;
    --������ ���������� ���������� �����
    CUSTVAL NUMBER :=0;
MORE_THAN_2PHONES EXCEPTION;
BEGIN
 OPEN SEARCHCUST_CURSOR; 
 FETCH SEARCHCUST_CURSOR INTO SEARCHCUST_REC;
 IF ( SEARCHCUST_CURSOR%FOUND = TRUE ) THEN
    CUSTVAL:= SEARCHCUST_REC.CUSTOMERPHONES; 
 END IF; 
 IF (CUSTVAL > 2) THEN
    RAISE MORE_THAN_2PHONES;
 ELSE 
    INSERT INTO Phone (idrest,nphone)
    VALUES (id_rest,n_phone);
 END IF;
 CLOSE SEARCHCUST_CURSOR; 
EXCEPTION
    WHEN MORE_THAN_2PHONES THEN
    RAISE_APPLICATION_ERROR (-20001,'This customer has already two phone numbers ');
END ADDPHONE;
/


/*1� �� ������������� ������������ ���������� �� ����� ADDTABLESCATEGORY, �� ����������� 
������ ����������, ������ ���� ��������� ����������, ������ ����������� ��� ���� ��������� 
��� ������ ��������� (���� ��� ���� �������). � ��������� �� ���� ����� ��� ��������� ������� 
��������� ���� ���������. � ���������� �� ��������� �� ��� �������� ���� ������ ���������.
�� 1� ��� ������� �� ���� ��� ���� ��� ������� ���������, �� 2� ������� ��������� + 1, �.�.�.
� ������������� ����� ������� ����������� ���������- ��� ������ ��������� �� ������� ���� NULL ��� ���� ��� �������.*/

CREATE OR REPLACE PROCEDURE ADDTABLESCATEGORY (TABLE_CAT IN VARCHAR,NUMBER_OF_TABLES IN NUMBER,FLOOR_TABLE NUMBER ,EMBADON_TABLE NUMBER ) 
IS
CODE NUMBER:=11;
LIMITCODE NUMBER:= CODE + NUMBER_OF_TABLES;
BEGIN 
for I in 1..NUMBER_OF_TABLES loop
    CODE := CODE + 1; 
    INSERT INTO RestTable(notable , embadon, floor  , noBook , cat)
    VALUES (CODE,EMBADON_TABLE,FLOOR_TABLE,NULL,TABLE_CAT);
end loop; 
END ADDTABLESCATEGORY;
/

ALTER TABLE RestTable
DROP COLUMN noBook;
ALTER TABLE RestTable
ADD noBook int;

/*1� �� ������������� ������������ ���������� �� �����
TABLEREMOVE � ����� �� ������� �� ��������� ��� ������
���� ��������� ��� �� �o ��������� ��� �� �� ���� �� ���� ���
����������� ��� ����������� �� ���� �� ����� ������ �������.
(��� ����������� � ����� ��� on delete cascade ) */

CREATE OR REPLACE PROCEDURE TABLEREMOVE (table_number IN NUMBER) 
IS
BEGIN 
    DELETE FROM Table_Serv WHERE table_number=table_num;
    DELETE FROM RecordBook WHERE table_number=nu_table;
    DELETE FROM RestTable WHERE table_number=notable;
END TABLEREMOVE;
/


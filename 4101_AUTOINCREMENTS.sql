--���������� ��������� ��������� ���� ������ RecordBook
create sequence reservationNo minvalue 1 start with 1 increment by 1;

--�������� ���� ������ ���� ������ ��������� RecordBook
ALTER TABLE RecordBook ADD reservationNo VARCHAR2 (30);

--������� ��� ������ ��� ������������� �� ��� �������� ��������
UPDATE RecordBook set RecordBook.reservationNo=reservationNo.nextval;
select * FROM Phone;

--���������� ��������� ��������� ��� ������� ��� �������
create sequence idrest minvalue 100 start with 100 increment by 1;

--������� ��� ������� ��� ����������� ���� ���� ������ ��� ����������
UPDATE Customer set Customer.idrest=idrest.nextval;

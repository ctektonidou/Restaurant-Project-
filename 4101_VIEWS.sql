--���������� View �� ��� ���������� ��� ��������� ��� ����� ���������� minprice ��� �� ���� ��� ��� minprices
CREATE VIEW Biggest_minprices AS
SELECT tableCat , minprice
FROM CategoryTable
WHERE minprice > (SELECT AVG(minprice) FROM CategoryTable);

--�������� ��� View Biggest_minprices
SELECT * FROM Biggest_minprices;

--���������� View �� ��� ������ ��� ��������� , ��� ������ ��� ��������� ���� ��� ��� ��������� ���� ����� ������ �� �������
--������� ��� ������������ �� �� ���������� ��� ��� ���� ��� ������ ��������� noBook
CREATE VIEW Biggest_noBook AS
SELECT notable ,noBook , cat
FROM RestTable
WHERE noBook > (SELECT AVG(noBook) FROM RestTable);

--�������� ��� View Biggest_noBook
SELECT * FROM Biggest_noBook;

--A��� ��� ��������
CREATE VIEW ola AS
SELECT Customer.Lname,RecordBook.bill , RestTable.cat
FROM Customer,RecordBook, RestTable
where Customer.idrest= RecordBook.idrest and RecordBook.nu_table= RestTable.notable;

--�������� ��� View ola
SELECT * FROM ola;

--����������� � ���� minprice �� ����� ����� ���� ��� �� 0
ALTER TABLE CategoryTable
ADD CHECK (minprice>=0);

--����������� � ���� bill �� ����� ����� ���� ��� �� 0
ALTER TABLE RecordBook
ADD CHECK (bill>=0);

--����������� � ���� price �� ����� ����� ���� ��� �� 0
ALTER TABLE Services
ADD CHECK (price>=0);

--����������� � ���� num_of_tables �� ����� ����� ���� ��� �� 0 ���� ����� �������������
ALTER TABLE CategoryTable
ADD CHECK (num_of_table>=0);

--����������� � ���� noBook �� ����� ����� ���� ��� �� 0 ���� ����� �������������
ALTER TABLE RestTable
ADD CHECK (noBook>=0);

--����������� ��� � ���������� ���������� ��� �� ����� ������������ ���� ����������
ALTER TABLE RecordBook
ADD CHECK (DateOut>=DateIn);








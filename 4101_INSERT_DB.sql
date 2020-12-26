insert into Customer (idrest,id,Lname,Fname,regDate)
    VALUES (100,'AH121514','PETROU','PETROS',TO_DATE ('02-03-2019' ,'DD-MM-YYYY'));    
    
insert into Customer (idrest,id,Lname,Fname,regDate)
    VALUES (101,'AM151616','MARIOU','MARIA',TO_DATE ('06-07-2019' ,'DD-MM-YYYY'));    
    
insert into Customer (idrest,id,Lname,Fname,regDate)
    VALUES (102,'AK787898','NIKOU','NIKOS',TO_DATE ('07-10-2019' ,'DD-MM-YYYY')); 
--insert into Phone (idrest) select (idrest) from Customer;
    
insert into Phone (idrest,nphone)
 VALUES(100,6944204672);
 
insert into Phone (idrest,nphone)
 VALUES(100,6948682414);
 
insert into Phone (idrest,nphone)
 VALUES(101,6940587154);
 
insert into Phone (idrest,nphone)
 VALUES(102,6988138354); 

insert into CategoryTable (tableCat , num_of_table , minprice )
 VALUES ('dithesio',5,20.00);

insert into CategoryTable (tableCat , num_of_table , minprice )
 VALUES ('trithesio',5,35.00);

insert into CategoryTable (tableCat , num_of_table , minprice )
 VALUES ('tetrathesio',5,50.00);

insert into CategoryTable (tableCat , num_of_table , minprice )
 VALUES ('eksathesio',5,80.00); 
    
insert into RestTable (notable , embadon, floor  , noBook , cat)
 VALUES (1,0.5,0,0,'dithesio');

insert into RestTable (notable , embadon, floor  , noBook , cat)
 VALUES (2,1,0,3,'trithesio');

insert into RestTable (notable , embadon, floor  , noBook , cat)
 VALUES (3,1.5,1,2,'tetrathesio');

insert into RestTable (notable , embadon, floor  , noBook , cat)
 VALUES (4,2,1,1,'eksathesio');

insert into RecordBook (DateIn,DateOut,idrest,bill,nu_table)
    VALUES (TO_DATE ('03-03-2019 07:00:00','DD-MM-YYYY HH-MI-SS'),TO_DATE ('03-03-2019 09:00:00','DD-MM-YYYY HH-MI-SS'),100,55.00,3);
    
insert into RecordBook (DateIn,DateOut,idrest,bill,nu_table)
    VALUES (TO_DATE ('14-03-2019 02:00:00','DD-MM-YYYY HH-MI-SS'),TO_DATE ('14-03-2019 03:30:00','DD-MM-YYYY HH-MI-SS'),101,88.50,4);    

insert into RecordBook (DateIn,DateOut,idrest,bill,nu_table)
    VALUES (TO_DATE ('07-04-2019 06:00:00','DD-MM-YYYY HH-MI-SS'),TO_DATE ('07-04-2019 08:15:00','DD-MM-YYYY HH-MI-SS'),102,70.00,3);

insert into Services (Catserv,price)
    VALUES ('fortistis',2.5);
    
insert into Services (Catserv,price)
    VALUES ('paidiko_kathisma',8.5);  
    
insert into Services (Catserv,price)
    VALUES ('tablet',4);    

insert into Table_Serv (table_num,Service_table)
    VALUES (1,'paidiko_kathisma');
    
insert into Table_Serv (table_num,Service_table)
    VALUES (2,'fortistis');    
    
insert into Table_Serv (table_num,Service_table)
    VALUES (2,'tablet');      
    
insert into Table_Serv (table_num,Service_table)
    VALUES (3,'fortistis');  
    
insert into Table_Serv (table_num,Service_table)
    VALUES (3,'paidiko_kathisma');    

insert into Table_Serv (table_num,Service_table)
    VALUES (4,'fortistis');  
    
ALTER TABLE Customer
ADD Afm int;
    
ALTER TABLE Customer
ADD UNIQUE (Afm);

ALTER TABLE RestTable
DROP COLUMN noBook;

ALTER TABLE RestTable
ADD noBook int;

UPDATE Customer 
set Afm = 123456789
where idrest = 100;

UPDATE Customer 
set Afm = 234567891
where idrest = 101;

UPDATE Customer 
set Afm = 345678912
where idrest = 102;


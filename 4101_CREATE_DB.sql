create table Customer (idrest NUMBER,id VARCHAR(8) not null, Lname VARCHAR(20), Fname VARCHAR (20),regDate DATE,
    PRIMARY KEY (idrest));

create table Phone ( idrest NUMBER , nphone NUMBER,
  PRIMARY KEY (idrest, nphone),
  FOREIGN KEY (idrest) REFERENCES Customer (idrest));
  
create table CategoryTable (tableCat VARCHAR(20), num_of_table NUMBER, minprice NUMBER,
  PRIMARY KEY (tableCat));
  
create table RestTable (notable NUMBER, embadon NUMBER , floor NUMBER not null , noBook NUMBER not null,  cat varchar(20),
  PRIMARY KEY (notable),
  FOREIGN KEY (cat) REFERENCES CategoryTable (tableCat));
  
create table  RecordBook (DateIn DATE ,DateOut DATE, idrest NUMBER, bill NUMBER, nu_table NUMBER,
  PRIMARY KEY (DATEIN,DATEOUT,idrest),
  FOREIGN KEY (idrest) REFERENCES Customer(idrest), 
  FOREIGN KEY (nu_table) REFERENCES RestTable (notable));  
  
create table  Services (Catserv VARCHAR(20),price NUMBER,
    PRIMARY KEY (Catserv));  
    
create table Table_Serv (table_num NUMBER , Service_table VARCHAR(20),
    PRIMARY KEY (table_num,Service_table),
    FOREIGN KEY (table_num) REFERENCES RestTable (notable),
    FOREIGN KEY (Service_table) REFERENCES Services (Catserv)); 


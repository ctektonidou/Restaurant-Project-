Να κατασκευαστούν anonymous blocks (ένα για κάθε διαδικασία / συνάρτηση / σκανδαλισμό) που θα εκτελούν τις παραπάνω αποθηκευμένες διαδικασίες / συναρτήσεις / σκανδαλισμούς(μέσω πυροδότησης συμβάντος) και θα
δείχνουν πως οι διαδικασίες/ συναρτήσεις/ σκανδαλισμοί που κατασκευάσατε παραπάνω λειτουργούν. Αν κατά την
εκτέλεση κάθε αντίστοιχου anonymous block δεν είναι εμφανές στον εξεταστή ότι η συνάρτηση ή διαδικασία ή σκανδαλισμός λειτουργεί (όχι μόνο συντακτικά αλλά και
λογικά) τότε θα μηδενίζεται και η διαδικασία / συνάρτηση / σκανδαλισμός που καλείται από το block. */

/*1α*/
declare
begin
    BOOKTABLE(102,4,'11/10/2020');
end;
/

/*1β*/
declare
begin
    ADDPHONE (100,6944204853);
end;
/

/*1γ*/
declare
begin
    ADDTABLESCATEGORY ('eksathesio',2,3,2);
end;
/

/*1δ*/
declare
begin
    TABLEREMOVE (11);
end;
/

/*2α*/
SET SERVEROUTPUT ON
--select TABLEEXISTS (12) from dual;
declare
    x integer;
    putline number;
begin
    select TABLEEXISTS (2) into x from dual;
    DBMS_OUTPUT.PUT_LINE(x);
end;
/

/*2β*/
SET SERVEROUTPUT ON
--select TABLEEXISTS (12) from dual;
declare
    x integer;
    putline number;
begin
    select TABLERESERVED (2) into x from dual;
    DBMS_OUTPUT.PUT_LINE(x);
end;
/

/*3α*/
declare
begin
    insert into Customer (idrest,id,Lname,Fname,regDate,Afm)
    VALUES (103,'ke122514','kosta','kostas',TO_DATE ('03-03-2019' ,'DD-MM-YYYY'),123456736);    
end;
/

declare
begin
    insert into Services (Catserv,price)
    VALUES ('pipila',13.5);
end;
/

/*3β*/
declare
begin
    insert into RecordBook (DateIn,DateOut,idrest,bill,nu_table)
    VALUES (TO_DATE ('07-04-2018 06:00:00','DD-MM-YYYY HH-MI-SS'),TO_DATE ('07-04-2018 08:15:00','DD-MM-YYYY HH-MI-SS'),102,NULL,4);
end;
/


/*3γ*/
declare
begin
    insert into RecordBook (DateIn,DateOut,idrest,bill,nu_table)
    VALUES (TO_DATE ('07-12-2020 06:00:00','DD-MM-YYYY HH-MI-SS'),TO_DATE ('07-12-2020 08:15:00','DD-MM-YYYY HH-MI-SS'),102,0,4);
end;
/

/*3δ.i*/
declare
begin
    insert into RecordBook (DateIn,DateOut,idrest,bill,nu_table)
    VALUES (TO_DATE ('07-08-2020 06:00:00','DD-MM-YYYY HH-MI-SS'),TO_DATE ('07-08-2020 08:15:00','DD-MM-YYYY HH-MI-SS'),102,0,4);
end;
/

/*3δ.ii*/
declare
begin
    insert into RestTable (notable , embadon, floor  , noBook , cat)
    VALUES (25,0.5,0,0,'dithesio');
end;
/


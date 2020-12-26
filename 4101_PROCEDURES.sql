/*1α Να κατασκευαστεί αποθηκευμένη διαδικασία με όνομα
BOOKTABLE, με παραμέτρους κωδικό πελάτη, κωδικό τραπεζιού,
ημερομηνία προσέλευσης και θα καταχωρεί την κράτηση στον
πίνακα κρατήσεων. Προφανώς θα αποθηκεύεται και ο αριθμός
της κράτησης-με χρήση ακολουθίας (SEQUENCE)*/

CREATE OR REPLACE PROCEDURE BOOKTABLE (id_rest IN NUMBER,nu_Table IN NUMBER,Date_In IN DATE)
IS
BEGIN
    INSERT INTO RecordBook (DateIn,DateOut,idrest,bill,nu_table,reservationNo)
    VALUES (Date_In,Date_In,id_rest,NULL,nu_Table,reservationNo.NEXTVAL);
END BOOKTABLE;
/


/*1β Να κατασκευαστεί αποθηκευμένη διαδικασία με όνομα
ADDPHONE, με παραμέτρους κωδικό πελάτη και τηλέφωνο και
θα κάνει την καταχώρηση στον πίνακα τηλεφώνων. Η διαδικασία
θα πρέπει να βλέπει πόσα τηλέφωνα έχει ήδη ο πελάτης και αν
υπάρχουν ήδη δυο τηλέφωνα σε αυτόν το πελάτη τότε η
διαδικασία θα προκαλεί user defined exception – ώστε να μην
επιτραπεί η προσθήκη νέου τηλεφώνου.*/

CREATE OR REPLACE PROCEDURE ADDPHONE (id_rest IN NUMBER,n_phone IN NUMBER) 
IS
cursor SEARCHCUST_CURSOR is
    select COUNT(*) AS CUSTOMERPHONES from Phone WHERE id_rest=idrest;
     --Δήλωση μεταβλητής εγγραφής
    SEARCHCUST_REC SEARCHCUST_CURSOR%ROWTYPE;
    --Δήλωση μεταβλητής επιστροφής τιμής
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


/*1γ Να κατασκευαστεί αποθηκευμένη διαδικασία με όνομα ADDTABLESCATEGORY, με παραμέτρους 
κωδικό κατηγορίας, αριθμό νέων τραπεζιών κατηγορίας, όροφος τοποθέτησης των νέων τραπεζιών 
και εμβαδό τραπεζιού (ίδιο για κάθε τραπέζι). Η συνάρτηση θα έχει ακόμα μια παράμετρο κωδικός 
εκκίνησης νέου τραπεζιού. Η διαδικασία θα καταχωρεί τα νέα τραπέζια στον πίνακα τραπεζιών.
Το 1ο νέο τραπέζι θα έχει την τιμή του κωδικού εκκίνησης, το 2ο κωδικός εκκίνησης + 1, κ.ο.κ.
Η υπολογιζόμενη στήλη –πλήθος δεσμευμένων τραπεζιών- του πίνακα τραπεζιών θα παίρνει τιμή NULL για κάθε νέο τραπέζι.*/

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

/*1δ Να κατασκευαστεί αποθηκευμένη διαδικασία με όνομα
TABLEREMOVE η οποία θα δέχεται ως παράμετρο τον κωδικό
ενός τραπεζιού και θα τo διαγράφει από τη ΒΔ μαζί με όλες τις
πληροφορίες που σχετίζονται με αυτό σε τυχόν άλλους πίνακες.
(Δεν επιτρέπεται η χρήση του on delete cascade ) */

CREATE OR REPLACE PROCEDURE TABLEREMOVE (table_number IN NUMBER) 
IS
BEGIN 
    DELETE FROM Table_Serv WHERE table_number=table_num;
    DELETE FROM RecordBook WHERE table_number=nu_table;
    DELETE FROM RestTable WHERE table_number=notable;
END TABLEREMOVE;
/


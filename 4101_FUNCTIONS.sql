/*2α Να κατασκευαστεί αποθηκευμένη συνάρτηση με όνομα
TABLEEXISTS που θα δέχεται ως παράμετρο τον κωδικό ενός
τραπεζιού και θα επιστρέφει τιμή 0 αν το τραπέζι δεν υπάρχει στο
εστιατόριο ή θα επιστρέφει τιμή 1 αν το τραπέζι υπάρχει.*/

create or replace function TABLEEXISTS (table_number IN NUMBER) 
return number
AS
-- Δήλωση μεταβλητής κέρσορα
-- Το τραπέζι ανήκει στο εστιατόριο αν βρεθεί στον πίνακα RestTable.
cursor SEARCHTABLE_CURSOR is
select table_number from RestTable WHERE table_number=notable;
--Δήλωση μεταβλητής εγγραφής
SEARCHTABLE_REC SEARCHTABLE_CURSOR%ROWTYPE;
-- Δήλωση μεταβλητής επιστροφής τιμής
TABLEVAL NUMBER;
BEGIN 
  -- Εκτέλεσε κέρσορα
  OPEN SEARCHTABLE_CURSOR;
  -- Αν το τραπέζι ανήκει στο εστιατόριο θέσε τιμή 0 στη μεταβλητή RETVAL αλλιώς θέσε τιμή -1
  FETCH SEARCHTABLE_CURSOR INTO SEARCHTABLE_REC;
  IF ( SEARCHTABLE_CURSOR%FOUND = TRUE ) THEN
  TABLEVAL:= 1;
  ELSE
  TABLEVAL:= 0;
  END IF;
  -- Κλείσε κέρσορα
  CLOSE SEARCHTABLE_CURSOR;
  -- Επέστρεψε την τιμή της μεταβλητής RETVAL
 RETURN TABLEVAL;
END TABLEEXISTS;
/


/*2β Να κατασκευαστεί αποθηκευμένη συνάρτηση με όνομα TABLERESERVED  που θα δέχεται ως παράμετρο τον 
κωδικό ενός τραπεζιού και θα επιστρέφει τιμή 0 αν το τραπέζι δεν είναι κρατημένο ή τιμή clientID
(ο κωδικός του πελάτη που το έχει κρατήσει) αν το τραπέζι είναι κρατημένο τη χρονική στιγμή που
καλείται η συνάρτηση. Σε περίπτωση που το τραπέζι δεν ανήκει στο εστιατόριο θα επιστρέφει -1 για 
τον έλεγχο αυτό να χρησιμοποιηθεί η προηγούμενη συνάρτηση.*/

create or replace function TABLERESERVED (table_number IN NUMBER) 
return number
AS
-- Δήλωση μεταβλητής κέρσορα
-- Το τραπέζι ανήκει στο εστιατόριο αν βρεθεί στον πίνακα RestTable.
cursor SEARCHTABLE_CURSOR is
select * from RestTable WHERE table_number=notable;
-- Δήλωση μεταβλητής εγγραφής
SEARCHTABLE_REC SEARCHTABLE_CURSOR%ROWTYPE;
-- Δήλωση μεταβλητής επιστροφής τιμής
TABLEVAL NUMBER;

--Το τραπέζι είναι κρατημένο εαν βρεθεί στον πίνακα RecordBook με την ημερομηνία που ψάχνει ο χρήστης
cursor SEARCHRES_CURSOR is
select DateIn,idrest from RecordBook WHERE table_number=nu_table;
--and DateIn = TO_CHAR(SYSDATE,'DD/MM/YYYY HH-MI-SS');
-- Δήλωση μεταβλητής εγγραφής
SEARCHRES_REC SEARCHRES_CURSOR%ROWTYPE;
-- Δήλωση μεταβλητής επιστροφής τιμής
RESVAL NUMBER;
CLL NUMBER;

BEGIN 
  -- Εκτέλεσε κέρσορα
  OPEN SEARCHTABLE_CURSOR;
  -- Εκτέλεσε κέρσορα
  OPEN SEARCHRES_CURSOR;
  -- Αν το τραπέζι ανήκει στο εστιατόριο θέσε τιμή 0 ή δώσε τον κωδικό πελάτη στη μεταβλητή TABLEVAL αλλιώς θέσε τιμή -1
  FETCH SEARCHTABLE_CURSOR INTO SEARCHTABLE_REC;
  IF ( SEARCHTABLE_CURSOR%FOUND = TRUE ) THEN
  -- Αν το τραπέζι δεν είναι κρατημένο θέσε τιμή 0 στη μεταβλητή RESVAL αλλιώς επέστρεψε τον κωδικό του πελάτη που το έχει κρατημένο
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
  --Κλείσε κέρσορα
  CLOSE SEARCHTABLE_CURSOR;
  --Επέστρεψε την τιμή της μεταβλητής RETVAL
 RETURN TABLEVAL; 
END;
/


/*2γ Να κατασκευαστεί αποθηκευμένη συνάρτηση με όνομα CALCULATEBILL που θα δέχεται ως παραμέτρους τον κωδικό ενός κρατημένου 
τραπεζιού και τον κωδικό του πελάτη που το έχει κρατήσει και θα επιστρέφει το κόστος που πρέπει να πληρώσει ο πελάτης. 
Για να τον υπολογισμό του συνολικού κόστους θα λάβετε υπόψη το ποσό που αντιστοιχεί στην κατηγορία του τραπεζιού και τα ποσά
που συνδέονται με όλες τις παροχές του τραπεζιού.Αν ο πελάτης δεν το έχει κρατήσει η συνάρτηση θα επιστρέφει -1.  */

--create or replace function CALCULATEBILL ( table_number IN NUMBER ,  id_rest IN NUMBER ) 
--return number
--AS
---- Δήλωση μεταβλητής ονόματος παροχής
--SERVNAME TABLE_SERV.SERVICE_TABLE%TYPE:=NULL; 
---- Δήλωση μεταβλητής τιμής παροχής
--SERVCOST SERVICES.PRICE%TYPE:=NULL;
--
---- Αρχικά ελέγχουμε αν είναι κρατημένο ,είναι κρατημένο εαν βρεθεί στον πίνακα RecordBook με την ημερομηνία που ψάχνει ο χρήστης
---- Δήλωση μεταβλητής κέρσορα
--cursor SEARCHRES_CURSOR is
--select DateIn,idrest from RecordBook WHERE table_number=nu_table and DateIn = TO_CHAR(SYSDATE,'DD/MM/YYYY HH-MI-SS');
---- Δήλωση μεταβλητής εγγραφής
--SEARCHRES_REC SEARCHRES_CURSOR%ROWTYPE;
---- Δήλωση μεταβλητής επιστροφής τιμής
--RESVAL NUMBER;
--
----Δήλωση μεταβλητής κέρσορα
----Οι παροχές που έχει το τραπέζι βρίσκοντα στον πίνακα Table_Serv.
--cursor SEARCHSERV_CURSOR is
--select service_table from Table_Serv WHERE table_number = table_num;
----Δήλωση μεταβλητής εγγραφής
--SEARCHSERV_REC SEARCHSERV_CURSOR%ROWTYPE;
--
----Δήλωση μεταβλητής κέρσορα
----Το κόστος της παροχής υπάρχει στη στήλη price του πίνακα Services
--cursor SEARCHSERVCOST_CURSOR is
--select price from Services WHERE catServ = SERVNAME;
----Δήλωση μεταβλητής εγγραφής του παραπάνω κέρσορα
--SEARCHSERVCOST_REC SEARCHSERVCOST_CURSOR%ROWTYPE; 
--
----Δήλωση μεταβλητής κέρσορα
----Το κόστος της κατηγορίας του τραπεζιού υπάρχει στη στήλη minprice του πίνακα CategoryTable 
--cursor SEARCHCAT_CURSOR is
--select minprice from CategoryTable WHERE tableCat.CategoryTable=cat.RestTable;
----Δήλωση μεταβλητής εγγραφής του παραπάνω κέρσορα
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
--  -- Εαν βρει τον κωδικό του πελάτη με την ημερομηνίατην σημερινή τότε μπαίνει και ψάχνει τις υπηρεσίες που προσφέρει για να βγάλει την τιμή.
--  IF (SEARCHRES_CURSOR%FOUND = TRUE) THEN 
--  -- Βρες όλες τις παροχές που έχει το τραπέζι με κωδικό table_num
--  -- Για κάθε παροχή βάλε το όνομα της στη μεταβλητή SERVNAME 
--  FETCH SEARCHSERV_CURSOR INTO SEARCHSERV_REC;
--  WHILE ( SEARCHSERV_CURSOR%FOUND = TRUE ) LOOP
--  SERVNAME:= SEARCHSERV_REC.SERVICE_TABLE;
--  -- Για κάθε παροχή που έχει το τραπέζι βρες πόσο κοστίζει
--  -- και βάλτο στη μεταβλητή SEVCOST 
--  FETCH SEARCHSERVCOST_CURSOR INTO SEARCHSERVCOST_REC;
--  IF ( SEARCHSERVCOST_CURSOR%FOUND = TRUE ) THEN
--  SERVCOST:=SEARCHSERVCOST_REC.price;
--  END IF;
--  END LOOP;
--  ELSE
--  RESVAL:= -1;
--  END IF; 
--  RETURN RESVAL;
--  --Κλείσε κέρσορα
--  CLOSE SEARCHSERV_CURSOR;
--  CLOSE SEARCHRES_CURSOR;
--  CLOSE SEARCHDVDCOST_CURSOR;
--  RETURN TOTALCOST;
--END;


/*2δ Nα κατασκευαστεί αποθηκευμένη συνάρτηση με όνομα CLIENTMONEYPAIDYEAR με παραμέτρους κωδικό πελάτη, έτος και
θα επιστρέφει πόσα χρήματα συνολικά έχει πληρώσει ο πελάτης στο εστιατόριο για το έτος της παραμέτρου. */

--create or replace function CLIENTMONEYPAIDYEAR (id_rest IN NUMBER,yearno IN YEAR)
--return number
--AS
--TOTALCOST NUMBER(5,1) :=0;
--BEGIN
--
--END;
--/ 

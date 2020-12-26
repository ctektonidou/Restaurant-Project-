/*3α Να δημιουργηθούν οι απαραίτητοι triggers που θα
εξασφαλίζουν ότι όλα τα αλφαριθμητικά στοιχεία στους πίνακες
πελάτης και παροχές θα είναι καταχωρημένα στη βάση
δεδομένων με κεφαλαία γράμματα. */

create or replace trigger CAPITALCUSTTRIGGER
before INSERT or UPDATE on Customer
FOR EACH ROW
BEGIN
 --’λλαξε την τιμή των:NEW.idrest,:NEW.id,:NEW.Lname,:NEW.Fname,:NEW.regDate,:NEW.afm χρησιμοποιώντας τη συνάρτηση UPPER της SQL
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
 --’λλαξε την τιμή των:NEW.catServ,:NEW.price χρησιμοποιώντας τη συνάρτηση UPPER της SQL
 :NEW.catServ := UPPER( :NEW.catServ );
 :NEW.price := UPPER( :NEW.price );
END;
/ 


/*3β Για λόγους ακεραιότητας της βάσης να δημιουργηθεί trigger που θα εξασφαλίζει πως η ώρα προσέλευσης σε μία κράτηση θα είναι 
 μελλοντική. Σε αντίθετη περίπτωση θα διακόπτεται από το transaction με αντίστοιχη πρόκληση εξαίρεσης (user defined) */
 
create or replace trigger HOURTRIGGER
before INSERT or UPDATE on RecordBook
FOR EACH ROW
DECLARE
 HOUREXCEPTION EXCEPTION;
-- Δήλωση μεταβλητής που θα αποθηκεύει την μέρα και ώρα 
HOURATDAY CHAR(13); 
BEGIN
--Πάρε τον αριθμό ώρας της σημερινής ημερομηνίας
 HOURATDAY:= TO_CHAR(SYSDATE,'DD-MM-YYYY HH'); 
 IF (HOURATDAY > TO_CHAR(:NEW.DateIn,'DD-MM-YYYY HH')) THEN
    RAISE HOUREXCEPTION;
 END IF; 
EXCEPTION 
WHEN HOUREXCEPTION THEN
    RAISE_APPLICATION_ERROR(-20001,'Access denied ,hour is not in the future');
END;
/


/*3γ Για λόγους ασφαλείας να δημιουργηθεί trigger που θα αποτρέπει την πρόσβαση για λόγους πανδημίας -στον πίνακα 
κρατήσεων τους χειμερινούς μήνες. */

create or replace trigger MONTHTRIGGER
before INSERT or UPDATE on RecordBook
FOR EACH ROW
DECLARE
-- Δήλωση μεταβλητών εξαιρέσεων χειμερινού μήνα
MONTHEXCEPTION EXCEPTION;
-- Δήλωση μεταβλητής που θα αποθηκεύει τον αριθμό του μήνα(0-11)
MONTHOFYEAR NUMBER; 
-- Δήλωση σταθερας Ιανουάριου
JANUARY CONSTANT NUMBER :=1; 
FEBRUARY CONSTANT NUMBER :=2; 
DECEMBER CONSTANT NUMBER :=12; 
 -- Δήλωση μεταβλητής που θα αποθηκεύει την ημέρα του μηνά το μήνα , καθώς και το χρόνο στη μορφή 'MM' π.χ. '31/12/2020'
 TODAY CHAR(2); 
BEGIN
--Πάρε τον αριθμό μήνα της σημερινής ημερομηνίας
 --Αν είναι ιανουάριος προκάλεσε εξαίρεση 
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
--Αν προκύψει εξαίρεση MONTHEXCEPTION εκτέλεσε την RAISE_APPLICATION_ERROR για διακοπή του σκανδαλισμού και του transaction στο 
--οποίο λαμβάνει μέρος και αυτός ο trigger
WHEN MONTHEXCEPTION THEN
 RAISE_APPLICATION_ERROR(-20001,'Access denied on this month,its winter, try to book a table again in spring'); 
END;


/*3δ Να κατασκευαστούν σκανδαλισμοί οι οποίοι θα εξασφαλίζουν την ακεραιότητα: 

i. της υπολογιζόμενης στήλης του πίνακα τραπεζιών κατά την προσθήκη ή διαγραφή μιας γραμμής από τον πίνακα κρατήσεων.
Ο σκανδαλισμός θα έχει όνομα TABLEBOOKTIMESTRIGGER.- noBook*/

create or replace trigger TABLEBOOKTIMESTRIGGER
before INSERT or DELETE on RecordBook
FOR EACH ROW
BEGIN
 IF INSERTING THEN --Ισοδύναμο με 'IF INSERTING = TRUE THEN'
    UPDATE RestTable SET noBook=NVL(noBook,0)+1 WHERE notable=:NEW.nu_table;
 END IF;
 IF DELETING THEN
    UPDATE RestTable SET  noBook= noBook -1 WHERE notable=:OLD.nu_table;
 END IF;
END;
/ 


/*3δ
ii. της υπολογιζόμενης στήλης του πίνακα κατηγοριών κατά την προσθήκη ή διαγραφή μιας γραμμής από 
τον πίνακα τραπεζιών. Ο σκανδαλισμός θα έχει όνομα CATEGORYTABLESCOUNTTRIGGER.- num_of_table */

create or replace trigger CATEGORYTABLESCOUNTTRIGGER
before INSERT or DELETE on RestTable
FOR EACH ROW
BEGIN
 IF INSERTING THEN --Ισοδύναμο με 'IF INSERTING = TRUE THEN'
 UPDATE CategoryTable SET num_of_table=NVL(num_of_table,0)+1 WHERE tableCat=:NEW.cat;
 END IF;
 IF DELETING THEN
 UPDATE CategoryTable SET  num_of_table= num_of_table -1 WHERE tableCat=:OLD.cat;
 END IF;
END;
/ 


/*3δ
iii. Της υπολογιζόμενης στήλης λογαριασμού του πίνακα κρατήσεων κατά την προσθήκη μιας κράτησης. Ο σκανδαλισμός θα 
έχει όνομα RESERVATIONBILLTRIGGER. Για να υπολογιστεί το ποσό ο σκανδαλισμός θα πρέπει να καλέσει την αποθηκευμένη συνάρτηση
CALCULATEBILL.- bill*/
--
--create or replace trigger RESERVATIONBILLTRIGGER
--before INSERT or DELETE on RecordBook
--FOR EACH ROW
--BEGIN
-- IF INSERTING THEN --Ισοδύναμο με 'IF INSERTING = TRUE THEN'
--    UPDATE RecordBook SET num_of_table=NVL(num_of_table,0)+1 WHERE tableCat=:NEW.cat;
-- END IF;
-- IF DELETING THEN
--    UPDATE CategoryTable SET  num_of_table= num_of_table -1 WHERE tableCat=:OLD.cat;
-- END IF;
--END;
--/ 


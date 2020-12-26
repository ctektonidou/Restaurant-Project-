--Δημιουργία αυτόματης αρίθμησης στον πίνακα RecordBook
create sequence reservationNo minvalue 1 start with 1 increment by 1;

--Εισαγωγή νέας στήλης στον πίνακα κρατήσεων RecordBook
ALTER TABLE RecordBook ADD reservationNo VARCHAR2 (30);

--Γέμισμα της στήλης που δημιουργήθηκε με την αυτόματη αρίθμηση
UPDATE RecordBook set RecordBook.reservationNo=reservationNo.nextval;
select * FROM Phone;

--Δημιουργία αυτόματης αρίθμησης των κωδικών των πελατών
create sequence idrest minvalue 100 start with 100 increment by 1;

--Γέμισμα των κωδικών του εστιατορίου κάθε νέου πελάτη που εντάσσεται
UPDATE Customer set Customer.idrest=idrest.nextval;

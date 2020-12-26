--Δημιουργία View με τις κατηγορίες των τραπεζιών που έχουν μεγαλύτερη minprice από το μέσο όρο των minprices
CREATE VIEW Biggest_minprices AS
SELECT tableCat , minprice
FROM CategoryTable
WHERE minprice > (SELECT AVG(minprice) FROM CategoryTable);

--Εμφάνιση του View Biggest_minprices
SELECT * FROM Biggest_minprices;

--Δημιουργία View με τον αριθμό του τραπεζιού , τον αριθμό των κρατήσεων αλλά και την κατηγορία στην οποία ανήκει το τραπέζι
--παίρνει τις καταχωρήσεις με το μεγαλύτερο από τον μέσο όρο αριθμό κρατήσεων noBook
CREATE VIEW Biggest_noBook AS
SELECT notable ,noBook , cat
FROM RestTable
WHERE noBook > (SELECT AVG(noBook) FROM RestTable);

--Εμφάνιση του View Biggest_noBook
SELECT * FROM Biggest_noBook;

--AΥΤΟ ΔΕΝ ΤΡΕΧΕΙΙΙ
CREATE VIEW ola AS
SELECT Customer.Lname,RecordBook.bill , RestTable.cat
FROM Customer,RecordBook, RestTable
where Customer.idrest= RecordBook.idrest and RecordBook.nu_table= RestTable.notable;

--Εμφάνιση του View ola
SELECT * FROM ola;

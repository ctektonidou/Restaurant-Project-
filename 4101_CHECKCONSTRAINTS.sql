--Περιορισμός η τιμή minprice να είναι πάντα πάνω από το 0
ALTER TABLE CategoryTable
ADD CHECK (minprice>=0);

--Περιορισμός η τιμή bill να είναι πάντα πάνω από το 0
ALTER TABLE RecordBook
ADD CHECK (bill>=0);

--Περιορισμός η τιμή price να είναι πάντα πάνω από το 0
ALTER TABLE Services
ADD CHECK (price>=0);

--Περιορισμός η τιμή num_of_tables να είναι πάντα πάνω από το 0 αφού είναι υπολογιζόμενη
ALTER TABLE CategoryTable
ADD CHECK (num_of_table>=0);

--Περιορισμός η τιμή noBook να είναι πάντα πάνω από το 0 αφού είναι υπολογιζόμενη
ALTER TABLE RestTable
ADD CHECK (noBook>=0);

--Περιορισμός πως η ημερομηνία αποχώρησης δεν θα είναι παρελθοντική αλλα μελλοντική
ALTER TABLE RecordBook
ADD CHECK (DateOut>=DateIn);








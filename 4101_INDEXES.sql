CREATE INDEX idx_fullname
ON Customer (LName,Fname);

CREATE INDEX idx_lastname
ON Customer (LName);

CREATE INDEX idx_dateInOut
ON RecordBook (DateIn,DateOut);


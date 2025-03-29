DROP TABLE Transaction CASCADE CONSTRAINTS;
DROP TABLE AuthorizedAccess CASCADE CONSTRAINTS;
DROP TABLE Account CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Client CASCADE CONSTRAINTS;

-- Create Client table
CREATE TABLE Client (
    ClientID NUMBER PRIMARY KEY NOT NULL,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    Gender VARCHAR2(1) CHECK(Gender IN('M', 'F')),
    BirthDate DATE,
    TelNumber VARCHAR2(13) NOT NULL,
    Email VARCHAR2(100) NOT NULL CHECK(REGEXP_LIKE(Email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'))
);

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID NUMBER PRIMARY KEY NOT NULL,
    TelNumber VARCHAR2(13) NOT NULL,
    Email VARCHAR2(100) NOT NULL CHECK(REGEXP_LIKE(Email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'))
);

-- Create Account table
CREATE TABLE Account (
    AccountID NUMBER PRIMARY KEY NOT NULL,
    CreationDate DATE NOT NULL,
    Balance NUMBER,
    CurrencyCode CHAR(3) NOT NULL CHECK(LENGTH(CurrencyCode) = 3 AND REGEXP_LIKE(CurrencyCode, '^[A-Z]{3}$')),
    OwnerID NUMBER, FOREIGN KEY (OwnerID) REFERENCES Client(ClientID),
    EmployeeID NUMBER, FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Create AuthorizedAccess table
CREATE TABLE AuthorizedAccess (
    ClientID NUMBER NOT NULL, FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    AccountID NUMBER NOT NULL, FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    Limit NUMBER
);

-- Create Transaction table
CREATE TABLE Transaction (
    SerialNumber NUMBER NOT NULL,
    AccountID NUMBER NOT NULL,
    PRIMARY KEY (SerialNumber, AccountID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    Time TIMESTAMP,
    Amount NUMBER NOT NULL,
    Incoming NUMBER(1) NOT NULL,
    IBAN VARCHAR2(34),
    Type VARCHAR2(8) NOT NULL CHECK(Type IN('Movement', 'Transfer'))
);

-- INSERT --
--  Client table
INSERT INTO Client (ClientID, FirstName, LastName, Gender, BirthDate, TelNumber, Email) VALUES
(1, 'Fox', 'Boniface', 'F', TO_DATE('1990-05-10', 'YYYY-MM-DD'), '1234567890', 'fox.boniface@example.com');
INSERT INTO Client (ClientID, FirstName, LastName, Gender, BirthDate, TelNumber, Email) VALUES
(2, 'Cass', 'Jaymes', 'M', TO_DATE('1985-02-14', 'YYYY-MM-DD'), '2345678901', 'cass.jaymes@example.com');
INSERT INTO Client (ClientID, FirstName, LastName, Gender, BirthDate, TelNumber, Email) VALUES
(3, 'Rolf', 'Horatio', 'M', TO_DATE('1980-09-30', 'YYYY-MM-DD'), '3456789012', 'rolf.horatio@example.com');
INSERT INTO Client (ClientID, FirstName, LastName, Gender, BirthDate, TelNumber, Email) VALUES
(4, 'Redd', 'Brannon', 'M', TO_DATE('1992-12-05', 'YYYY-MM-DD'), '4567890123', 'redd.brannon@example.com');
INSERT INTO Client (ClientID, FirstName, LastName, Gender, BirthDate, TelNumber, Email) VALUES
(5, 'Joseph', 'Baldric', 'M', TO_DATE('1995-03-22', 'YYYY-MM-DD'), '5678901234', 'joseph.baldric@example.com');

-- Employee table
INSERT INTO Employee (EmployeeID, TelNumber, Email) VALUES
(1, '1112233445', 'employee1@example.com');
INSERT INTO Employee (EmployeeID, TelNumber, Email) VALUES
(2, '2223344556', 'employee2@example.com');
INSERT INTO Employee (EmployeeID, TelNumber, Email) VALUES
(3, '3334455667', 'employee3@example.com');
INSERT INTO Employee (EmployeeID, TelNumber, Email) VALUES
(4, '4445566778', 'employee4@example.com');
INSERT INTO Employee (EmployeeID, TelNumber, Email) VALUES
(5, '5556677889', 'employee5@example.com');

-- Account table
INSERT INTO Account (AccountID, CreationDate, Balance, CurrencyCode, OwnerID, EmployeeID) VALUES
(1, TO_DATE('2025-03-01', 'YYYY-MM-DD'), 1000.00, 'USD', 1, 1);
INSERT INTO Account (AccountID, CreationDate, Balance, CurrencyCode, OwnerID, EmployeeID) VALUES
(2, TO_DATE('2025-03-02', 'YYYY-MM-DD'), 2000.00, 'USD', 2, 2);
INSERT INTO Account (AccountID, CreationDate, Balance, CurrencyCode, OwnerID, EmployeeID) VALUES
(3, TO_DATE('2025-03-03', 'YYYY-MM-DD'), 3000.00, 'USD', 3, 3);
INSERT INTO Account (AccountID, CreationDate, Balance, CurrencyCode, OwnerID, EmployeeID) VALUES
(4, TO_DATE('2025-03-04', 'YYYY-MM-DD'), 1500.00, 'USD', 4, 4);
INSERT INTO Account (AccountID, CreationDate, Balance, CurrencyCode, OwnerID, EmployeeID) VALUES
(5, TO_DATE('2025-03-05', 'YYYY-MM-DD'), 2500.00, 'USD', 5, 5);

-- AuthorizedAccess table
INSERT INTO AuthorizedAccess (ClientID, AccountID, Limit) VALUES
(1, 1, 500.00);
INSERT INTO AuthorizedAccess (ClientID, AccountID, Limit) VALUES
(2, 2, 1000.00);
INSERT INTO AuthorizedAccess (ClientID, AccountID, Limit) VALUES
(3, 3, 1500.00);
INSERT INTO AuthorizedAccess (ClientID, AccountID, Limit) VALUES
(4, 4, 750.00);
INSERT INTO AuthorizedAccess (ClientID, AccountID, Limit) VALUES
(5, 5, 1200.00);

-- Transaction table
INSERT INTO Transaction (SerialNumber, AccountID, Time, Amount, Incoming, IBAN, Type) VALUES
(1, 1, TO_TIMESTAMP('2025-03-10 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 500.00, 1, 'DE12345678901234567890', 'Movement');
INSERT INTO Transaction (SerialNumber, AccountID, Time, Amount, Incoming, IBAN, Type) VALUES
(2, 2, TO_TIMESTAMP('2025-03-11 14:45:00', 'YYYY-MM-DD HH24:MI:SS'), 1000.00, 0, 'DE98765432109876543210', 'Transfer');
INSERT INTO Transaction (SerialNumber, AccountID, Time, Amount, Incoming, IBAN, Type) VALUES
(3, 3, TO_TIMESTAMP('2025-03-12 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 1500.00, 1, 'FR12345678901234567890', 'Movement');
INSERT INTO Transaction (SerialNumber, AccountID, Time, Amount, Incoming, IBAN, Type) VALUES
(4, 4, TO_TIMESTAMP('2025-03-13 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 750.00, 0, 'IT12345678901234567890', 'Transfer');
INSERT INTO Transaction (SerialNumber, AccountID, Time, Amount, Incoming, IBAN, Type) VALUES
(5, 5, TO_TIMESTAMP('2025-03-14 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1200.00, 1, 'GB12345678901234567890', 'Movement');


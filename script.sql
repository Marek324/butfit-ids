CREATE TABLE Client (
    ClientID NUMBER PRIMARY KEY NOT NULL,
    FirstName VARCHAR2(50) NOT NULL,
    MiddleName VARCHAR2(50),
    LastName VARCHAR2(50) NOT NULL,
    Gender VARCHAR2(1) CHECK(Gender IN('M', 'F')),
    BirthDate DATE,
    TelNumber VARCHAR2(13) NOT NULL,
    Email VARCHAR2(100) NOT NULL CHECK(REGEXP_LIKE(email, '^\w+@\w+\.\w+$'))
);

CREATE TABLE Employee (
    EmployeeID NUMBER PRIMARY KEY NOT NULL,
    TelNumber VARCHAR2(13) NOT NULL,
    Email VARCHAR2(100) NOT NULL CHECK(REGEXP_LIKE(email, '^\w+@\w+\.\w+$'))
);

CREATE TABLE Account (
    AccountID NUMBER PRIMARY KEY NOT NULL,
    CreationDate DATE NOT NULL,
    Balance NUMBER,
    CurrencyCode CHAR(3) NOT NULL CHECK(LENGTH(CurrencyCode) = 3 AND REGEXP_LIKE(CurrencyCode, '^[A-Z]{3}$')),
    OwnerID NUMBER, FOREIGN KEY (OwnerID) REFERENCES Client(ClientID),
    EmployeeID NUMBER, FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE AuthorizedAccess (
    ClientID NUMBER NOT NULL, FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    AccountID NUMBER NOT NULL, FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    Limit NUMBER
);

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


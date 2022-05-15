DROP TABLE Kunde CASCADE CONSTRAINTS;
DROP TABLE Account CASCADE CONSTRAINTS;
DROP TABLE Bestellung CASCADE CONSTRAINTS;
DROP TABLE Adresse CASCADE CONSTRAINTS;
DROP TABLE Bestellposition CASCADE CONSTRAINTS;
DROP TABLE Artikel CASCADE CONSTRAINTS;
DROP TABLE Buch CASCADE CONSTRAINTS;
DROP TABLE Hoerbuch CASCADE CONSTRAINTS;
DROP TABLE Sprecher CASCADE CONSTRAINTS;
DROP TABLE Verlag CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE AutorArtikelAssoziation CASCADE CONSTRAINTS;
DROP TABLE Nachbestellung CASCADE CONSTRAINTS;
DROP TABLE StatMonatsumsatz CASCADE CONSTRAINTS;
DROP TABLE StatTopArtikel CASCADE CONSTRAINTS;
DROP TABLE SprecherHoerbuchAssoziation CASCADE CONSTRAINTS;


-- Tabelle Kunde
CREATE TABLE Kunde (
    KundenID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    AccountID NUMBER
);



-- Tabelle Account
CREATE TABLE Account (
    AccountID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    EMail VARCHAR(255),
    PasswortHash VARCHAR(255),
    AccountTyp VARCHAR(30),
    LetzterLogin TIMESTAMP,
    Aktiv NUMBER
);

-- Tabelle Bestellung
CREATE TABLE Bestellung (
    BestellungID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Datum TIMESTAMP,
    Status VARCHAR(30),
    RechnungsadresseID NUMBER,
    LieferadresseID NUMBER,
    KundenID NUMBER,
    Gesamtpreis NUMBER
);

-- Tabelle Adresse
CREATE TABLE Adresse (
    AdresseID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Vorname VARCHAR(255),
    Nachname VARCHAR(255),
    Strasse VARCHAR(255),
    Hausnummer NUMBER,
    Postleitzahl NUMBER,
    Ort VARCHAR(255),
    KundenID NUMBER 
);

-- Tabelle Bestellpostion
CREATE TABLE Bestellposition (
    BestellpositionID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ArtikelID NUMBER,
    BestellungID NUMBER,
    Stueckpreis NUMBER,
    Steuersatz NUMBER,
    Menge NUMBER
);

-- Tabelle Artikel
CREATE TABLE Artikel (
    ArtikelID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Titel VARCHAR(255),
    Preis NUMBER,
    Steuersatz NUMBER,
    VerlagID NUMBER,
    Beschreibung VARCHAR(255),
    ISBN NUMBER,
    AnzahlVerkauft NUMBER,
    Erscheinungsdatum DATE,
    Sprache VARCHAR(50),
    AnzahlVerfuegbar NUMBER,
    Mindestbestand NUMBER
);

-- Tabelle Buch
CREATE TABLE Buch (
    ArtikelID NUMBER PRIMARY KEY,
    AnzahlSeiten NUMBER
);

-- Tabelle Hoerbuch
CREATE TABLE Hoerbuch (
    ArtikelID NUMBER PRIMARY KEY,
    Spieldauer NUMBER
);

-- Tabelle Sprecher
CREATE TABLE Sprecher (
    SprecherID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(255)
);

-- Tabelle SprecherHoerbuchAssoziation (n:m-Beziehung aufgelï¿½st)
CREATE TABLE SprecherHoerbuchAssoziation (
    SprecherID NUMBER,
    ArtikelID NUMBER,
    PRIMARY KEY (SprecherID, ArtikelID)
);

-- Tabelle Verlag
CREATE TABLE Verlag (
    VerlagID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(255)
);

-- Tabelle Autor
CREATE TABLE Autor (
    AutorID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(255)
);

-- Tabelle AutorArtikelAssoziation (n:m-Beziehung aufgelï¿½st)
CREATE TABLE AutorArtikelAssoziation (
    AutorID NUMBER,
    ArtikelID NUMBER,
    PRIMARY KEY (AutorID, ArtikelID)
);

-- Tabelle Nachbestellung
CREATE TABLE Nachbestellung (
    NachbestellungID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ArtikelID NUMBER,
    Anzahl NUMBER,
    Bestellstatus VARCHAR(20)
);

-- Tabelle StatMonatsumsatz
CREATE TABLE StatMonatsumsatz (
    MonatsID NUMBER PRIMARY KEY,
    Umsatz NUMBER
);

-- Tabelle StatTopArtikel
CREATE TABLE StatTopArtikel (
    MonatsID NUMBER PRIMARY KEY,
    ArtikelID NUMBER
);




-- Kunde - Account (1)
ALTER TABLE Kunde 
ADD CONSTRAINT kunde_account FOREIGN KEY (AccountID) REFERENCES Account (AccountID);

-- Bestellung - Kunde (2)
ALTER TABLE Bestellung
ADD CONSTRAINT bestellung_kunde FOREIGN KEY (KundenID) REFERENCES Kunde (KundenID);

-- Bestellung - Adresse (3)
ALTER TABLE Bestellung
ADD CONSTRAINT bestellung_rechnungsadresse FOREIGN KEY (RechnungsadresseID) REFERENCES Adresse (AdresseID);

ALTER TABLE Bestellung
ADD CONSTRAINT bestellung_lieferadresse FOREIGN KEY (LieferadresseID) REFERENCES Adresse (AdresseID);

-- Bestellposition - Bestellung (4)
ALTER TABLE Bestellposition
ADD CONSTRAINT bestellposition_bestellung FOREIGN KEY (BestellungID) REFERENCES Bestellung (BestellungID);

-- Bestellposition - Artikel (5)
ALTER TABLE Bestellposition
ADD CONSTRAINT bestellposition_artikel FOREIGN KEY (ArtikelID) REFERENCES Artikel (ArtikelID);

-- Buch - Artikel (6)
ALTER TABLE Buch
ADD CONSTRAINT buch_artikel FOREIGN KEY (ArtikelID) REFERENCES Artikel (ArtikelID);

-- Hoerbuch - Artikel (7)
ALTER TABLE Hoerbuch
ADD CONSTRAINT hoerbuch_artikel FOREIGN KEY (ArtikelID) REFERENCES Artikel (ArtikelID);

--Hoerbuch - Sprecher (8)
ALTER TABLE SprecherHoerbuchAssoziation
ADD CONSTRAINT sprecherhoerbuchassoziation_sprecher FOREIGN KEY (SprecherID) REFERENCES Sprecher (SprecherID);

ALTER TABLE SprecherHoerbuchAssoziation
ADD CONSTRAINT sprecherhoerbuchassoziation_hoerbuch FOREIGN KEY (ArtikelID) REFERENCES Hoerbuch (ArtikelID);

-- Artikel - Verlag (9)
ALTER TABLE Artikel
ADD CONSTRAINT artikel_verlag FOREIGN KEY (VerlagID) REFERENCES Verlag (VerlagID);

-- Artikel - Autor (10)
ALTER TABLE AutorArtikelAssoziation
ADD CONSTRAINT artikel_autorartikelassoziation FOREIGN KEY (ArtikelID) REFERENCES Artikel (ArtikelID);

ALTER TABLE AutorArtikelAssoziation
ADD CONSTRAINT autor_autorartikelassoziation FOREIGN KEY (AutorID) REFERENCES Autor (AutorID);

-- StatTopArtikel - Artikel (11)
ALTER TABLE StatTopArtikel
ADD CONSTRAINT stattopartikel_artikel FOREIGN KEY (ArtikelID) REFERENCES Artikel (ArtikelID);

-- Artikel - Nachbestellung (12)
ALTER TABLE Nachbestellung
ADD CONSTRAINT nachbestellung_artikel FOREIGN KEY (ArtikelID) REFERENCES Artikel (ArtikelID);

-- Adresse - Kunde (13)
Alter Table Adresse
ADD CONSTRAINT adresse_kunde FOREIGN KEY (KundenID) REFERENCES Kunde (KundenID);


SELECT * FROM Nachbestellung;
UPDATE Artikel SET AnzahlVerfuegbar = 9 WHERE ArtikelID = 1;


-- Daten für die Prozedur
INSERT INTO Verlag(Name) 
    VALUES('VerlagX');

INSERT INTO Artikel (Titel, Preis, Steuersatz, VerlagID, Beschreibung, ISBN, AnzahlVerkauft, Erscheinungsdatum, Sprache, AnzahlVerfuegbar, Mindestbestand)
    VALUES ('Artikel1', 10, 0.19, 1, 'Gutes Buch', 12345, 0, TO_DATE('01.01.2020'), 'deutsch', 10, 9);
    
INSERT INTO Buch (ArtikelID, AnzahlSeiten)
    VALUES (1, 100);

INSERT INTO Account (Email, Passworthash, accounttyp, letzterlogin, aktiv)
    VALUES ('kunde.a@gmail.com', NULL, 'Kunde', NULL, 1);
INSERT INTO Account (Email, Passworthash, accounttyp, letzterlogin, aktiv)
    VALUES ('kunde.b@gmail.com', NULL, 'Kunde', NULL, 1);
INSERT INTO Account (Email, Passworthash, accounttyp, letzterlogin, aktiv)
    VALUES ('kunde.c@gmail.com', NULL, 'Kunde', NULL, 1);
    
INSERT INTO Kunde (AccountID)
    VALUES (1);
INSERT INTO Kunde (AccountID)
    VALUES (2);
INSERT INTO Kunde (AccountID)
    VALUES (3);

INSERT INTO Adresse (Vorname, Nachname, Strasse, Hausnummer, postleitzahl, ort, kundenid)
    VALUES ('Max', 'Mustermann', 'X Straße', 1, 12345, 'Gummersbach', 1);


INSERT INTO Bestellung (Datum, Status, RechnungsadresseID, LieferadresseID, KundenID, Gesamtpreis)
    VALUES (TO_DATE('01.02.2022'), 'Offen', 1, 1, 1, 10);
INSERT INTO Bestellung (Datum, Status, RechnungsadresseID, LieferadresseID, KundenID, Gesamtpreis)
    VALUES (TO_DATE('01.02.2022'), 'Offen', 1, 1, 2, 10);
INSERT INTO Bestellung (Datum, Status, RechnungsadresseID, LieferadresseID, KundenID, Gesamtpreis)
    VALUES (TO_DATE('01.02.2022'), 'Nicht Offen', 1, 1, 2, 10);
INSERT INTO Bestellung (Datum, Status, RechnungsadresseID, LieferadresseID, KundenID, Gesamtpreis)
    VALUES (TO_DATE('01.02.2022'), 'Nicht Offen', 1, 1, 3, 10);

INSERT INTO Bestellposition (ArtikelID, bestellungid, stueckpreis, steuersatz, menge)
    VALUES (1, 1, 10, 0.19, 1);
INSERT INTO Bestellposition (ArtikelID, bestellungid, stueckpreis, steuersatz, menge)
    VALUES (1, 2, 10, 0.19, 1);
INSERT INTO Bestellposition (ArtikelID, bestellungid, stueckpreis, steuersatz, menge)
    VALUES (1, 3, 10, 0.19, 1);
INSERT INTO Bestellposition (ArtikelID, bestellungid, stueckpreis, steuersatz, menge)
    VALUES (1, 4, 10, 0.19, 1);
    
COMMIT;

CREATE SEQUENCE Bestell_Seq; 
DROP SEQUENCE Bestell_Seq;

-- Funktion createSurrogateKey
CREATE OR REPLACE Function createSurrogateKey
RETURN VARCHAR
IS
surrogateKey VARCHAR(50);
BEGIN
surrogateKey:= Sysdate || ' - ' || BESTELL_SEQ.nextval;
RETURN surrogateKey;
END createSurrogateKey;


DECLARE
a varchar(50);
BEGIN
a := createSurrogateKey;
dbms_output.put_line(a);
END;
    
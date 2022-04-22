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
    EMail VARCHAR(30),
    PasswortHash VARCHAR(255),
    AccountTyp VARCHAR(30),
    LetzterLogin DATE,
    Aktiv NUMBER
);

-- Tabelle Bestellung
CREATE TABLE Bestellung (
    BestellungID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Datum DATE,
    Status VARCHAR(30),
    RechnungsadresseID NUMBER,
    LieferadresseID NUMBER,
    KundenID NUMBER,
    Gesamtpreis NUMBER
);

-- Tabelle Adresse
CREATE TABLE Adresse (
    AdresseID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Vorname VARCHAR(20),
    Nachname VARCHAR(20),
    Strasse VARCHAR(20),
    Hausnummer NUMBER,
    Postleitzahl NUMBER,
    Ort VARCHAR(20)
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
    Titel VARCHAR(30),
    Preis NUMBER,
    Steuersatz NUMBER,
    VerlagID NUMBER,
    Beschreibung VARCHAR(50),
    ISBN NUMBER,
    AnzahlVerkauft NUMBER,
    Erscheinungsdatum DATE,
    Sprache VARCHAR(20),
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
    Name VARCHAR(40)
);

-- Tabelle SprecherHoerbuchAssoziation (n:m-Beziehung aufgel�st)
CREATE TABLE SprecherHoerbuchAssoziation (
    SprecherID NUMBER,
    ArtikelID NUMBER,
    PRIMARY KEY (SprecherID, ArtikelID)
);

-- Tabelle Verlag
CREATE TABLE Verlag (
    VerlagID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(50)
);

-- Tabelle Autor
CREATE TABLE Autor (
    AutorID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(50)
);

-- Tabelle AutorArtikelAssoziation (n:m-Beziehung aufgel�st)
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






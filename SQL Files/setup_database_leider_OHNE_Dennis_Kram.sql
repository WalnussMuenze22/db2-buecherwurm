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

BEGIN
    FOR jobRow IN (
        SELECT
            owner as creator,
            job_name
        FROM SYS.ALL_SCHEDULER_JOBS
    )
    LOOP
        DBMS_SCHEDULER.drop_job(jobRow.job_name);
    END LOOP;
END;
/



-- Tabelle Kunde
CREATE TABLE Kunde (
    KundenID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    AccountID NUMBER
);



-- Tabelle Account
CREATE TABLE Account (
    AccountID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    EMail VARCHAR(255) NOT NULL UNIQUE,
    PasswortHash VARCHAR(255) NOT NULL,
    AccountTyp VARCHAR(30),
    LetzterLogin TIMESTAMP,
    Aktiv NUMBER
);

-- Tabelle Bestellung
CREATE TABLE Bestellung (
    BestellungID VARCHAR(50) PRIMARY KEY,
    Datum TIMESTAMP,
    Status VARCHAR(30) DEFAULT 'editierbar',
    RechnungsadresseID NUMBER NOT NULL,
    LieferadresseID NUMBER Not NULL,
    KundenID NUMBER NOT NULL,
    Gesamtpreis NUMBER DEFAULT 0.0 NOT NULL
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
    KundenID NUMBER NOT NULL 
);

-- Tabelle Bestellpostion
CREATE TABLE Bestellposition (
    BestellpositionID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ArtikelID NUMBER NOT NULL,
    BestellungID VARCHAR(50) NOT NULL,
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
    VerlagID NUMBER NOT NULL,
    Beschreibung VARCHAR(2047),
    ISBN NUMBER,
    AnzahlVerkauft NUMBER,
    Erscheinungsdatum DATE,
    Sprache VARCHAR(2),
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

-- Tabelle SprecherHoerbuchAssoziation (n:m-Beziehung aufgel�st)
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
    ArtikelID NUMBER NOT NULL
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
/


















CREATE OR REPLACE VIEW BuchInformationen AS
SELECT Artikel.ArtikelID AS ArtikelID,
       Titel,
       Preis,
       Steuersatz,
       Beschreibung,
       ISBN,
       Erscheinungsdatum,
       Sprache,
       AnzahlVerfuegbar,
       MindestBestand,
       AnzahlVerkauft,
       AnzahlSeiten,
       Verlag.Name AS Verlag,
       LISTAGG(Autor.Name, '#') WITHIN GROUP (ORDER BY Autor.Name) AS AutorenListe
FROM Artikel
JOIN Buch ON (Artikel.ArtikelID = Buch.ArtikelID)
JOIN Verlag ON (Artikel.VerlagID = Verlag.VerlagID)
JOIN AutorArtikelAssoziation ON Artikel.ArtikelID = AutorArtikelAssoziation.ArtikelID
JOIN Autor ON AutorArtikelAssoziation.AutorID = Autor.AutorID
GROUP BY Artikel.ArtikelID,
         Titel,
         Preis,
         Steuersatz,
         Beschreibung,
         ISBN,
         Erscheinungsdatum,
         Sprache,
         AnzahlVerfuegbar,
         MindestBestand,
         AnzahlVerkauft,
         AnzahlSeiten,
         Verlag.Name
ORDER BY (Artikel.ArtikelID) ASC
;
/










CREATE OR REPLACE TRIGGER BuchInformationen_Instead_Of_Insert
    INSTEAD OF INSERT ON BuchInformationen
    FOR EACH ROW
DECLARE
    v_helpCounter NUMBER;
    
    v_artikelID NUMBER;
    V_autorId NUMBER;
    v_verlagId NUMBER;
    
    type t_MyVarcharTable is table of (Autor.Name%TYPE);
    v_neueAutorenTabelle t_MyVarcharTable;
BEGIN
    -- Verlag hinzufügen wenn er nicht existiert und ID in v_VerlagID speichern
    
    -- Existiert Verlag in Datenbank?
    SELECT COUNT(*)
    INTO v_helpCounter
    FROM Verlag
    WHERE Verlag.Name = :NEW.Verlag
    ;
    
    IF (v_helpCounter = 0) THEN
        INSERT INTO Verlag
        (Name)
        VALUES (:NEW.Verlag)
        RETURNING VerlagID INTO v_VerlagID
        ;
    -- Verlag existiert und ID in v_VerlagID speichern
    ELSE
        SELECT Verlag.verlagID
        INTO v_verlagId
        FROM Verlag
        WHERE Verlag.Name = :NEW.Verlag
        ;
    END IF;
    
    
    
    
    -- Daten in die Tabelle Artikel einfügen
    INSERT INTO Artikel
    (
        Titel,
        Preis,
        Steuersatz,
        VerlagID,
        Beschreibung,
        ISBN,
        Erscheinungsdatum,
        Sprache,
        AnzahlVerfuegbar,
        MindestBestand,
        AnzahlVerkauft
    )
    VALUES (
        :NEW.Titel,
        :NEW.Preis,
        :NEW.Steuersatz,
        v_VerlagID,
        :NEW.Beschreibung,
        :NEW.ISBN,
        :NEW.Erscheinungsdatum,
        :NEW.Sprache,
        :NEW.AnzahlVerfuegbar,
        :NEW.MindestBestand,
        :NEW.AnzahlVerkauft
    )
    RETURNING ArtikelID INTO v_ArtikelID
    ;
    
    
    
    
    -- Daten in die Tabelle Buch einfügen
    INSERT INTO Buch
    (ArtikelID, AnzahlSeiten)
    VALUES (v_ArtikelID, :NEW.AnzahlSeiten)
    ;
    
    
    
    
    -- Autoren die nicht existieren hinzufügen und Assoziation zwischen Autor und Artikel hinzufügen
    
    -- Nested Table mit den Autoren von NEW für den Artikel
    SELECT AutorName
    BULK COLLECT INTO v_neueAutorenTabelle
    FROM (
        WITH neueAutorenTabelle
        AS (
            SELECT :NEW.AutorenListe AS autorListeString
            FROM dual
        )
        SELECT REGEXP_SUBSTR (autorListeString, '[^#]+', 1, level) AutorName
        FROM neueAutorenTabelle
        CONNECT BY level <= length (autorListeString) - length (REPLACE(autorListeString, '#')) + 1
    );
    
    -- Assoziation zwischen Autor und Artikel hinzufügen und Autor ggf. anlegen
    FOR n IN v_neueAutorenTabelle.FIRST .. v_neueAutorenTabelle.LAST
    LOOP
        -- Existiert Autor in Datenbank?
        SELECT COUNT(*)
        INTO v_helpCounter
        FROM Autor
        WHERE Autor.Name = v_neueAutorenTabelle(n)
        ;
        
        
        -- Autor hinzufügen wenn er nicht existiert und ID in v_AutorID speichern
        IF (v_helpCounter = 0) THEN
            INSERT INTO Autor
            (Name)
            VALUES (v_neueAutorenTabelle(n))
            RETURNING AutorID INTO v_AutorID
            ;
        -- Autor existiert und ID in v_VerlagID speichern
        ELSE
            SELECT Autor.AutorID
            INTO v_AutorID
            FROM Autor
            WHERE Autor.Name = v_neueAutorenTabelle(n)
            ;
        END IF;
        
        
        -- Assoziation zwischen Autor und Artikel hinzufügen
        INSERT INTO AutorArtikelAssoziation
        (ArtikelID, AutorID)
        VALUES (v_ArtikelID, v_AutorID)
        ;
    END LOOP;
END;
/










CREATE OR REPLACE TRIGGER BuchInformationen_Instead_Of_Update
    INSTEAD OF UPDATE ON BuchInformationen
    FOR EACH ROW
DECLARE
    v_helpCounter NUMBER;
    v_helpContains NUMBER;
    
    v_artikelID NUMBER;
    V_autorId NUMBER;
    v_verlagId NUMBER;
    
    type t_MyVarcharTable is table of (Autor.Name%TYPE);
    v_neueAutorenTabelle t_MyVarcharTable;
    v_alteAutorenTabelle t_MyVarcharTable;
BEGIN
    -- #### Tabelle Artikel Updaten ####
    
    IF (:OLD.ArtikelID <> :NEW.ArtikelID)THEN
        raise_application_error(-6502, 'ArtikelID is immutable!');
    END IF;
    
    v_ArtikelID := :NEW.ArtikelID;
    
    IF (:OLD.Titel <> :NEW.Titel)THEN
        UPDATE Artikel
        SET Artikel.Titel = :NEW.Titel
        ;
    END IF;
    
    IF (:OLD.Preis <> :NEW.Preis)THEN
        UPDATE Artikel
        SET Artikel.Preis = :NEW.Preis
        ;
    END IF;
    
    IF (:OLD.Steuersatz <> :NEW.Steuersatz)THEN
        UPDATE Artikel
        SET Artikel.Steuersatz = :NEW.Steuersatz
        ;
    END IF;
    
    IF (:OLD.Beschreibung <> :NEW.Beschreibung)THEN
        UPDATE Artikel
        SET Artikel.Beschreibung = :NEW.Beschreibung
        ;
    END IF;
    
    IF (:OLD.ISBN <> :NEW.ISBN)THEN
        UPDATE Artikel
        SET Artikel.ISBN = :NEW.ISBN
        ;
    END IF;
    
    IF (:OLD.Erscheinungsdatum <> :NEW.Erscheinungsdatum)THEN
        UPDATE Artikel
        SET Artikel.Erscheinungsdatum = :NEW.Erscheinungsdatum
        ;
    END IF;
    
    IF (:OLD.Sprache <> :NEW.Sprache)THEN
        UPDATE Artikel
        SET Artikel.Sprache = :NEW.Sprache
        ;
    END IF;
    
    IF (:OLD.AnzahlVerfuegbar <> :NEW.AnzahlVerfuegbar)THEN
        UPDATE Artikel
        SET Artikel.AnzahlVerfuegbar = :NEW.AnzahlVerfuegbar
        ;
    END IF;
    
    IF (:OLD.MindestBestand <> :NEW.MindestBestand)THEN
        UPDATE Artikel
        SET Artikel.MindestBestand = :NEW.MindestBestand
        ;
    END IF;
    
    IF (:OLD.AnzahlVerkauft <> :NEW.AnzahlVerkauft)THEN
        UPDATE Artikel
        SET Artikel.AnzahlVerkauft = :NEW.AnzahlVerkauft
        ;
    END IF;
    
    
    
    
    -- Änderungen in der Tabelle Buch
    IF (:OLD.AnzahlSeiten <> :NEW.AnzahlSeiten) THEN
        UPDATE Buch
        SET AnzahlSeiten = :NEW.AnzahlSeiten;
    END IF;
    
    
    
    
    -- Referenz auf Verlag ändern und ggf. Verlag neu hinzufügen
    IF (:OLD.Verlag <> :NEW.Verlag) THEN
        -- Existiert Verlag in Datenbank?
        SELECT COUNT(*)
        INTO v_helpCounter
        FROM Verlag
        WHERE Verlag.Name = :NEW.Verlag
        ;
        
        -- Verlag hinzufügen wenn er nicht existiert und ID in v_VerlagID speichern
        IF (v_helpCounter = 0) THEN
            INSERT INTO Verlag
            (Name)
            VALUES (:NEW.Verlag)
            RETURNING VerlagID INTO v_VerlagID
            ;
        -- Verlag existiert und ID in v_VerlagID speichern
        ELSE
            SELECT Verlag.verlagID
            INTO v_verlagId
            FROM Verlag
            WHERE Verlag.Name = :NEW.Verlag
            ;
        END IF;
        
        -- VerlagID dem Artikel hinzufügen
        UPDATE Artikel
        SET VerlagID = v_VerlagID
        ;
    END IF;
    
    
    
    
    -- Referenzen auf Autoren ändern und ggf. Autoren hinzufügen 
    IF (:OLD.AutorenListe <> :New.AutorenListe) THEN
        -- Nested Table mit den Autoren von OLD für den Artikel
        SELECT AutorName
        BULK COLLECT INTO v_alteAutorenTabelle
        FROM (
            WITH alteAutorenTabelle
            AS (
                SELECT :OLD.AutorenListe AS autorListeString
                FROM dual
            )
            SELECT REGEXP_SUBSTR (autorListeString, '[^#]+', 1, level) AutorName
            FROM alteAutorenTabelle
            CONNECT BY level <= length (autorListeString) - length (REPLACE(autorListeString, '#')) + 1
        );
        
        
        -- Nested Table mit den Autoren von NEW für den Artikel
        SELECT AutorName
        BULK COLLECT INTO v_neueAutorenTabelle
        FROM (
            WITH neueAutorenTabelle
            AS (
                SELECT :NEW.AutorenListe AS autorListeString
                FROM dual
            )
            SELECT REGEXP_SUBSTR (autorListeString, '[^#]+', 1, level) AutorName
            FROM neueAutorenTabelle
            CONNECT BY level <= length (autorListeString) - length (REPLACE(autorListeString, '#')) + 1
        );
        
        
        -- Assoziation zwischen Autor und Artikel löschen, wenn Autor vom Artikel entfernt wurde
        FOR a IN v_alteAutorenTabelle.FIRST .. v_alteAutorenTabelle.LAST
        LOOP
            -- Prüfen ob Autor bei NEW noch existiert
            v_helpContains := 0;
            FOR n IN v_neueAutorenTabelle.FIRST .. v_neueAutorenTabelle.LAST
            LOOP
                IF (v_neueAutorenTabelle(n) = v_alteAutorenTabelle(a)) THEN
                    v_helpContains := 1;
                END IF;
            END LOOP;
            -- Wenn Autor beim Update entfernt wurde
            IF (v_helpContains = 0) THEN
                -- Speichert die AutorID vom Autor der vom Artikel entfernt wurde in v_AutorID
                SELECT AutorID
                INTO v_AutorID
                FROM Autor
                WHERE (v_alteAutorenTabelle(a) = Autor.Name)
                ;
                
                -- Löscht die Assoziation zwischen dem Autor und dem Artikel
                DELETE FROM AutorArtikelAssoziation
                WHERE (
                    AutorArtikelAssoziation.ArtikelID = v_ArtikelID
                    AND AutorArtikelAssoziation.AutorID = v_AutorID
                );
            END IF;
        END LOOP;
        
        
        -- Assoziation zwischen Autor und Artikel hinzufügen, wenn Autor dem Artikel hinzugefügt wurde und Autor ggf. anlegen
        FOR n IN v_neueAutorenTabelle.FIRST .. v_neueAutorenTabelle.LAST
        LOOP
            -- Prüfen ob Autor bei OLD schon existierte
            v_helpContains := 0;
            FOR a IN v_alteAutorenTabelle.FIRST .. v_alteAutorenTabelle.LAST
            LOOP
                IF (v_neueAutorenTabelle(n) = v_alteAutorenTabelle(a)) THEN
                    v_helpContains := 1;
                END IF;
            END LOOP;
            -- Wenn Autor beim Update hinzugefügt wurde
            IF (v_helpContains = 0) THEN
                -- Existiert Autor in Datenbank?
                SELECT COUNT(*)
                INTO v_helpCounter
                FROM Autor
                WHERE Autor.Name = v_neueAutorenTabelle(n)
                ;
                
                -- Autor hinzufügen wenn er nicht existiert und ID in v_AutorID speichern
                IF (v_helpCounter = 0) THEN
                    INSERT INTO Autor
                    (Name)
                    VALUES (v_neueAutorenTabelle(n))
                    RETURNING AutorID INTO v_AutorID
                    ;
                -- Autor existiert und ID in v_VerlagID speichern
                ELSE
                    SELECT Autor.AutorID
                    INTO v_AutorID
                    FROM Autor
                    WHERE Autor.Name = v_neueAutorenTabelle(n)
                    ;
                END IF;
                
                -- Assoziation zwischen Autor und Artikel hinzufügen
                INSERT INTO AutorArtikelAssoziation
                (ArtikelID, AutorID)
                VALUES (v_ArtikelID, v_AutorID)
                ;
            END IF;
        END LOOP;
    END IF;
END;
/










CREATE OR REPLACE TRIGGER BuchInformationen_Instead_Of_Delete
    INSTEAD OF DELETE ON BuchInformationen
    FOR EACH ROW
BEGIN
    raise_application_error(-20001, 'Deleting entries from BuchInformationen is not allowed!');
    /*
    -- Löscht den Eintrag aus der Tabelle Buch
    DELETE FROM Buch
    WHERE Buch.ArtikelID = :OLD.ArtikelID
    ;
    
    -- Löscht die Assoziation zum Autor
    DELETE FROM AutorArtikelAssoziation
    WHERE AutorArtikelAssoziation.ArtikelID = :OLD.ArtikelID
    ;
    
    -- Löscht den Eintrag aus der Tabelle Artikel
    DELETE FROM Artikel
    WHERE Artikel.artikelID = :OLD.ArtikelID
    ;
    */
END;
/



















CREATE OR REPLACE PROCEDURE adjust_minimum_stock
IS
    -- Der Wert für MindestBestand in Prozent gemessen am gesamt Verkauf im letzten Monat
    v_minBestandProzent NUMBER := 40;
    
    v_ArtikelID NUMBER;
    v_stueckVerkauftLetzterMonat NUMBER;
BEGIN
    FOR ArtikelRow IN (
        SELECT ArtikelID FROM Artikel
    )
    LOOP
        v_ArtikelID := ArtikelRow.ArtikelID;
        
        SELECT
        SUM(Bestellposition.Menge) AS stueckVerkauft
        INTO v_stueckVerkauftLetzterMonat
        FROM Bestellposition
        JOIN Bestellung ON Bestellposition.BestellungID = Bestellung.BestellungID
        WHERE (
            Bestellposition.ArtikelID = v_ArtikelID
            AND Datum BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'mm'), -1) and LAST_DAY(ADD_MONTHS(TRUNC(SYSDATE, 'mm'), -1))
            AND Bestellung.Status IN ('offen', 'versendet', 'zugestellt')
        )
        ;
        
        UPDATE Artikel
        SET Artikel.MindestBestand = ROUND(v_minBestandProzent / 100 * v_stueckVerkauftLetzterMonat, 0)
        WHERE Artikel.ArtikelID = v_ArtikelID
        ;
    END LOOP;
END;
/









create or replace procedure send_emails AS
    CURSOR accounts_cursor is (
        -- E-Mail-Adresse von Kunden, die seit zwichen 182 und 183 Tagen nicht eingelogt waren und dazu den Namen des Kunden aus seiner letzten Bestellung
        SELECT a.EMAIL, Adresse.NACHNAME
        FROM Account a
            join Kunde ku on a.ACCOUNTID = ku.ACCOUNTID
            join Bestellung on ku.KUNDENID = BESTELLUNG.KUNDENID
            join Adresse on BESTELLUNG.RECHNUNGSADRESSEID = ADRESSE.ADRESSEID
        WHERE   TO_DATE(sysdate) - cast(LETZTERLOGIN as date) >= 182
            AND TO_DATE(sysdate) - cast(LETZTERLOGIN as date) <  183
            AND BESTELLUNG.DATUM =
                --Datum der letzten Bestellung des jeweiligen Kunden
                (SELECT MAX(Datum)
                FROM Bestellung
                WHERE Bestellung.KUNDENID = ku.KUNDENID)
    );
    account_name ADRESSE.NACHNAME%type;
    account_email ACCOUNT.EMAIL%type;
    --l_mail_conn UTL_SMTP.connection;
Begin
    open accounts_cursor;
    Loop
        FETCH accounts_cursor into account_email, account_name;
        EXIT when accounts_cursor%notfound;
        dbms_output.put_line('Sending mail to ' || account_email || ' (' || account_name || ')');

        --E-Mail senden vom TH Server nicht möglich, aufgrund Berechtigungen: ORA-24247: Netzwerkzugriff von Access Control-Liste (ACL) abgelehnt
        --l_mail_conn := UTL_SMTP.open_connection('web13.alfahosting-server.de', 25);
        --UTL_SMTP.helo(l_mail_conn, 'studidb.gm.th-koeln.de');
        --UTL_SMTP.mail(l_mail_conn, 'buecherwurm@leopebe.de');
        --UTL_SMTP.rcpt(l_mail_conn, account_email);

        --UTL_SMTP.open_data(l_mail_conn);
        --UTL_SMTP.write_data(l_mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'To: ' || account_email || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'From: ' || 'buecherwurm@leopebe.de' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Subject: Wir vermissen Sie! ' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Sehr geerthe/r  Frau/Herr ' || account_name || ',' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'sie haben uns schon lange nicht mehr besucht. Schauen sie mal wieder bei uns vorbei und sehen sie sich unsere aktuellen Angebote an. ' || account_name || ',' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Wir wünschen Ihnen einen schönen Tag.' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Mit freundlichen Grüßen,' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Ihr Bücherwurm Team' || UTL_TCP.crlf);

        --UTL_SMTP.write_data(l_mail_conn, p_message || UTL_TCP.crlf || UTL_TCP.crlf);
        --UTL_SMTP.close_data(l_mail_conn);
        --UTL_SMTP.quit(l_mail_conn);
    end loop;
    close accounts_cursor;
end;
/










CREATE OR REPLACE FUNCTION show_period_revenue(startDatum DATE, endDatum DATE) return Number
IS
    umsatz Number := 0;
BEGIN
    for zeile IN
        (
            SELECT  GESAMTPREIS FROM BESTELLUNG WHERE (
                Datum BETWEEN startDatum AND endDatum
                AND Bestellung.Status IN ('offen', 'versendet', 'zugestellt')
            )
        )
        LOOP
            umsatz := umsatz + zeile.GESAMTPREIS;
        end loop;
    return umsatz;
end;
/







DROP SEQUENCE BESTELL_SEQ;

CREATE SEQUENCE BESTELL_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
;
/
-- Funktion create_surrogate_key
CREATE OR REPLACE Function create_surrogate_key
    RETURN VARCHAR
IS
    surrogateKey VARCHAR(50);
BEGIN
    surrogateKey:= Sysdate || ' - ' || BESTELL_SEQ.nextval;
    RETURN surrogateKey;
END create_surrogate_key;
/

-- Setzt den generierten Primärschlüssel in die Tabelle Bestellung ein
CREATE OR REPLACE TRIGGER insert_generated_primary_key_into_bestellung
BEFORE INSERT ON Bestellung
FOR EACH ROW
DECLARE
BEGIN
    :NEW.BestellungID := create_surrogate_key;
END;
/



















create or replace trigger account_logging
    after insert or update
    on ACCOUNT
    for each row
Declare
    Datetime varchar2(20);
    DBUSer varchar2(20);
Begin
    Datetime := TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS');
    SELECT SYS_CONTEXT ('USERENV', 'SESSION_USER') into DBUSer FROM DUAL;
    -- insert
    IF INSERTING THEN
        dbms_output.put_line( Datetime || ' Es wurde ein Account erstellt: DB-User: ' || DBUSer ||  ' AccountID: '||  :new.AccountID || ' Account E-Mail: ' || :new.EMail);
    -- update
    ELSIF UPDATING THEN
        IF :OLD.AKTIV = 1 AND :NEW.AKTIV = 0 THEN
            -- archiviert 
            dbms_output.put_line( Datetime || ' Es wurde ein Account archiviert: DB-User: ' || DBUSer ||  ' AccountID: '||  :old.AccountID || ' Account E-Mail: ' || :old.EMail);
        ELSE
            -- geändert
            dbms_output.put_line( Datetime || ' Es wurde ein Account geändert: DB-User: ' || DBUSer ||  ' AccountID: '||  :new.AccountID || ' Account E-Mail: ' || :new.EMail);
        END IF;
    end if;
end;
/










CREATE OR REPLACE TRIGGER add_price_to_order
BEFORE INSERT ON Bestellposition
FOR EACH ROW
DECLARE
    v_Stueckpreis NUMBER;
    v_Steuersatz NUMBER;
BEGIN
    SELECT Preis, Steuersatz
    INTO v_Stueckpreis, v_Steuersatz
    FROM Artikel
    WHERE (:NEW.ArtikelID = Artikel.ArtikelID)
    ;
    
    :NEW.Stueckpreis := v_Stueckpreis;
    :NEW.Steuersatz := v_Steuersatz;
END;
/










CREATE OR REPLACE TRIGGER add_to_stock_order
AFTER UPDATE OF AnzahlVerfuegbar ON Artikel
FOR EACH ROW
WHEN (NEW.AnzahlVerfuegbar < OLD.Mindestbestand)
DECLARE
    anzahlNachbestellung NUMBER;
    anzahlBestellposten NUMBER;
BEGIN
    SELECT COUNT(*) 
        INTO anzahlBestellposten 
        FROM Nachbestellung 
        WHERE Nachbestellung.ArtikelID = :OLD.ArtikelID;
    anzahlNachbestellung := (:OLD.MindestBestand * 1.20) - :NEW.AnzahlVerfuegbar;
    IF (anzahlBestellposten = 0) THEN
        INSERT INTO Nachbestellung (ArtikelID, Anzahl, Bestellstatus)
        VALUES (:NEW.ArtikelID, anzahlnachbestellung, NULL);
    ELSE 
        UPDATE Nachbestellung SET anzahl = anzahlnachbestellung WHERE Nachbestellung.ArtikelID = :OLD.ArtikelID;
    END IF;
END;
/










CREATE OR REPLACE TRIGGER trigger_reduceStock
    BEFORE UPDATE
    ON Bestellung
    for each row
    WHEN (new.status = 'offen' AND old.status = 'editierbar')
BEGIN
    for zeile IN (
        SELECT  ArtikelID, Menge  FROM Bestellposition  WHERE Bestellposition.BestellungID = :new.BestellungID
    )

    LOOP
        UPDATE ARTIKEL SET ANZAHLVERFUEGBAR = ANZAHLVERFUEGBAR - zeile.Menge WHERE zeile.ArtikelID = ARTIKEL.ARTIKELID;
    end loop;
END;
/























































































































































BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        comments           =>  'Passt den Mindestbestand anhand der Verkaufszahlen an',
        
        start_date         =>   SYSTIMESTAMP,
        end_date           =>   NULL,
        repeat_interval    =>  'FREQ=MONTHLY;BYMONTHDAY=1', /* Wird an jedem 1. eines Monat ausgeführt */
        
        job_name           =>  'adjust_mininum_stock_every_month',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'ADJUST_MINIMUM_STOCK',
        
        auto_drop          =>   FALSE,
        enabled            =>   TRUE
    );
END;
/









BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        comments           =>  'Versendet jeden Tag E-Mails an Accounts, die ein halbes Jahr nicht eingelogggt waren.',
        
        start_date         =>   SYSTIMESTAMP,
        end_date           =>   NULL,
        repeat_interval    =>  'FREQ = DAILY; INTERVAL = 1', /* wird täglich ausgeführt */
        
        job_name           =>  'send_emails_every_day',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'send_emails',
        
        auto_drop          =>   FALSE,
        enabled            =>   TRUE
    );
END;
/

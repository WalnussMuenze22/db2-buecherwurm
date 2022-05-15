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

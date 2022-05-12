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
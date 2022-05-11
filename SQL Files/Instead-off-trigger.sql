CREATE OR REPLACE TRIGGER BuchInformationenInsteadOf
    INSTEAD OF INSERT ON BuchInformationen
    FOR EACH ROW
DECLARE
    v_artikelID NUMBER;
    V_autorId NUMBER;
    v_verlagId NUMBER;
    
    v_helpCounter NUMBER;
BEGIN
    -- Fügt falls nicht vorhanden den Autor hinzu und speichert die neue oder schon existierende autorID in der Variable v_autorID
    SELECT COUNT(*)
    INTO v_helpCounter
    FROM Autor
    WHERE Autor.Name = :NEW.Autor
    ;
    
    IF (v_helpCounter = 0) THEN
        INSERT INTO Autor
        (Name)
        VALUES (:NEW.Autor)
        RETURNING autorID INTO v_autorID
        ;
    ELSE
        SELECT Autor.autorID
        INTO v_autorID
        FROM Autor
        WHERE Autor.Name = :NEW.Autor
        ;
    END IF;
    
    
    -- Fügt falls nicht vorhanden den Verlag hinzu und speichert die neue oder schon existierende verlagID in der Variable v_verlagID
    SELECT COUNT(*)
    INTO v_helpCounter
    FROM Verlag
    WHERE Verlag.Name = :NEW.Verlag
    ;
    
    IF (v_helpCounter = 0) THEN
        INSERT INTO Verlag
        (Name)
        VALUES (:NEW.Verlag)
        RETURNING verlagID INTO v_verlagId;
    ELSE
        SELECT Verlag.verlagID
        INTO v_verlagId
        FROM Verlag
        WHERE Verlag.Name = :NEW.Verlag
        ;
    END IF;
    
    
    -- Fügt die Daten in die Tabelle Artikel ein und speichert die artikelID in der Variable v_artikelID
    INSERT INTO Artikel
    (Titel, Preis, Steuersatz, Beschreibung, ISBN, Erscheinungsdatum, Sprache, AnzahlVerfuegbar, MindestBestand, AnzahlVerkauft, VerlagID)
    VALUES (:NEW.Titel, :NEW.Preis, :NEW.Steuersatz, :NEW.Beschreibung, :NEW.ISBN, :NEW.Erscheinungsdatum, :NEW.Sprache, :NEW.AnzahlVerfuegbar, :NEW.MindestBestand, :NEW.AnzahlVerkauft, v_verlagID)
    RETURNING artikelID INTO v_artikelID
    ;
    
    
    -- Fügt die Assoziation der Tabelle AutorArtikelAssoziation hinzu
    INSERT INTO AutorArtikelAssoziation
    (AutorID, ArtikelID)
    VALUES (v_autorID, v_artikelID)
    ;
    
    
    -- Fügt die restlichen Daten der Tabelle Buch hinzu
    INSERT INTO Buch
    (ArtikelID, AnzahlSeiten)
    VALUES (v_artikelID, :New.AnzahlSeiten)
    ;
END;
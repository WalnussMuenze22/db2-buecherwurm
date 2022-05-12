CREATE OR REPLACE TRIGGER Buch_Informationen_Instead_Of_Delete
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
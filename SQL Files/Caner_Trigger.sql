
-- Trigger
CREATE OR REPLACE TRIGGER add_to_stock_order
AFTER UPDATE OF AnzahlVerfuegbar ON Artikel
FOR EACH ROW
WHEN (NEW.AnzahlVerfuegbar < OLD.Mindestbestand)
DECLARE
anzahlNachbestellung NUMBER;
anzahlBestellposten NUMBER;
BEGIN
SELECT COUNT(*) INTO anzahlBestellposten FROM Nachbestellung WHERE Nachbestellung.ArtikelID = :OLD.ArtikelID;
anzahlNachbestellung := (:OLD.MindestBestand * 1.20) - :NEW.AnzahlVerfuegbar;
IF (anzahlBestellposten = 0) THEN
INSERT INTO Nachbestellung (ArtikelID, Anzahl, Bestellstatus)
    VALUES (:NEW.ArtikelID, anzahlnachbestellung, NULL);
ELSE 
UPDATE Nachbestellung SET anzahl = anzahlnachbestellung WHERE Nachbestellung.ArtikelID = :OLD.ArtikelID;
END IF;
END;
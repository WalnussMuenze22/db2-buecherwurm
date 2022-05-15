/**
 * Trigger
 * Von : Caner Özer
 * Triggername  :   add_to_stock_order
 * Beschreibung :   Ermitelt die zu bestellenden Artikel. Es sollen 20% mehr Artikel bestellt werden, als der Mindestbestand ist.
 * [E]vent      :   Wenn beim Artikel die verfügbare Menge geändert wird.
 * [C]ondition  :   Wenn die Menge sich verringert hat.
 * [A]ction     :   Die benötigten Artikel werden in die nachbestellen Tabelle eingetragen.
 */

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



--Testfall 1
--Die Känguru-Chroniken 
--Midestanzahl ist 8
--Vefügbar von 10 auf 5 setzen 
--Es sollten 4,6 Känguru-Chroniken nachbestellt werden 
UPDATE Artikel SET AnzahlVerfuegbar = 5 WHERE ArtikelID = 1;


--Testfall 2
--Die Känguru-Comics 1
--Midestanzahl ist 20
--Vefügbar von 24 auf 20 setzen 
--Es sind 2 bereits auf der Nachbestellungen Liste
--Die Nachbestellen Liste sollte auf 4 erhöt werden 
UPDATE Artikel SET AnzahlVerfuegbar = 20 WHERE ArtikelID = 2;


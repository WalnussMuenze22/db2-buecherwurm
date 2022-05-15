/**
 * Trigger
 * Von : Sven Heiter
 * Triggername  :   reduceStock
 * Beschreibung :   Bei Aufgabe einer Bestellung (Bestellstatus "offen")
 *                  werden alle enthaltenen Artikel im Bestand verringert
 * [E]vent      :   Update bei Bestellung von 'editierbar' zu 'offen'
 * [C]ondition  :
 * [M]ode       :
 * [A]ction     :   In der Tabelle Artikel AnzahlVerfuegbar reduzieren (=Menge ->Bestellposition) und Bestellung.Status auf "offen" setzen
 * 
 */

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

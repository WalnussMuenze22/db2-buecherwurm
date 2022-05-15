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
 *
 * Fragen:
 * -wie verhindere ich, dass mehr Artikel zur Bestellposition hinzugefügt werden als verfügbar sind?
 *      ->Before update or insert
 */

CREATE OR REPLACE TRIGGER reduce_stock       --Trigger mit dem Namen wird erstellt, oder, wenn bereits bestehend, ersetzt
    BEFORE UPDATE                                   --Before ->Bevor dem einfügen der Daten
    ON Bestellung
    for each row                                    --berücksichtigt alle Updates, falls es mehrere geben sollte
    WHEN (new.status = 'offen' AND old.status = 'editierbar') --Wenn der Status von 'editierbar' zu 'offen' geändert wird
    BEGIN


        --WITH Bestellpositionen AS (SELECT * FROM Bestellposition LEFT JOIN  Bestellung.BestellungID = Bestellposition.BestellungID);
           --Fügt diese Werte in die Tabelle V_artikel_menge ein
        --Bulk Collect -> Array


        for zeile IN (
            SELECT  ArtikelID, Menge  FROM Bestellposition  WHERE Bestellposition.BestellungID = :new.BestellungID
            )

        LOOP
            UPDATE ARTIKEL SET ANZAHLVERFUEGBAR = ANZAHLVERFUEGBAR - zeile.Menge WHERE zeile.ArtikelID = ARTIKEL.ARTIKELID;
        end loop;
    END;


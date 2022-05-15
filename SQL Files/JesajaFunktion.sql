-- Autor: Jesaja Storm

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
        );
        
        UPDATE Artikel
        SET Artikel.MindestBestand = ROUND(v_minBestandProzent / 100 * v_stueckVerkauftLetzterMonat, 0)
        WHERE Artikel.ArtikelID = v_ArtikelID
        ;
    END LOOP;
END;
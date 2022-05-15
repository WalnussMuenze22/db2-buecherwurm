-- Autor: Jesaja Storm

CREATE OR REPLACE PROCEDURE adjust_minimum_Stock
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
        )
        ;
        
        UPDATE Artikel
        SET Artikel.MindestBestand = ROUND(v_minBestandProzent / 100 * v_stueckVerkauftLetzterMonat, 0)
        WHERE Artikel.ArtikelID = v_ArtikelID
        ;
    END LOOP;
END;
/




BEGIN
    --DBMS_SCHEDULER.DROP_JOB ('adjust_mininum_stock_every_month');
    
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

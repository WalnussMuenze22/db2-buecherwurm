/**
 * Funktion
 * Von : Denis Kliewer
 * Triggername  :   get_gesamtpreis_median
 * Beschreibung :   Gibt den Median der Gesamtpreise in einem Bestimmten Zeitraum zurück
 */


CREATE OR REPLACE FUNCTION get_gesamtpreis_median(startZeit DATE,endZeit DATE)
	RETURN NUMBER
	AS
		v_median NUMBER := 0;
		v_uppermedian NUMBER;
		v_lowermedian NUMBER;
		v_bestellunganzahl NUMBER;
BEGIN	
	SELECT COUNT(*)
	INTO v_bestellunganzahl
	FROM Bestellung
	WHERE Datum BETWEEN startZeit AND endZeit AND Status IN ('offen','versendet','zugestellt');
    
	if mod(v_bestellunganzahl, 2) = 0 then
        
		SELECT Gesamtpreis
		INTO v_lowermedian
		FROM Bestellung
		WHERE Datum BETWEEN startZeit AND endZeit AND Status IN ('offen','versendet','zugestellt')
		ORDER BY Gesamtpreis
		OFFSET (ROUND(v_bestellunganzahl/2, 0)-1) ROW FETCH NEXT 1 row only;
		
		SELECT Gesamtpreis
		INTO v_uppermedian
		FROM Bestellung
		WHERE Datum BETWEEN startZeit AND endZeit AND Status IN ('offen','versendet','zugestellt')
		ORDER BY Gesamtpreis
		OFFSET (ROUND(v_bestellunganzahl/2, 0)) ROW FETCH NEXT 1 row only;
        
		v_median := ((v_uppermedian - v_lowermedian)/2);
	else
		SELECT Gesamtpreis
		INTO v_median
		FROM Bestellung
		WHERE Datum BETWEEN startZeit AND endZeit AND Status IN ('offen','versendet','zugestellt')
		ORDER BY Gesamtpreis
		OFFSET (ROUND(v_bestellunganzahl/2, 0)-1) ROW FETCH NEXT 1 row only;
	end if;
	
	RETURN v_median;
END;
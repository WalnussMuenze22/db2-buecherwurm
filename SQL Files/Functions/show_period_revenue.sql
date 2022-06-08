/**
 * Funktion
 * Von           : Sven Heiter
 * Funktionsname : show_period_revenue
 * Parameter     : Der Zeitraum für den der Umsatz ausgegeben werden soll
 * Rückgabe      : Der Umsatz für den gegebenen Zeitraum
 * Beschreibung  : Gibt den Umsatz für einen gegebenen Zeitraum aus
 */

CREATE OR REPLACE FUNCTION show_period_revenue(startDatum DATE, endDatum DATE) return Number
IS
    zeileGesamtpreis Number := 0;
    umsatz Number := 0;
BEGIN
    for zeile IN
        (
            SELECT BestellungId FROM BESTELLUNG WHERE (
                Datum BETWEEN startDatum AND endDatum
                AND Bestellung.Status IN ('offen', 'versendet', 'zugestellt')
            )
        )
        LOOP
            SELECT SUM(Bestellposition.Stueckpreis * Menge) AS GESAMTPREIS INTO zeileGesamtpreis
            FROM Bestellposition
            WHERE Bestellposition.BestellungID = zeile.BestellungId;
            
            umsatz := umsatz + zeileGesamtpreis;
        end loop;
    return umsatz;
end;
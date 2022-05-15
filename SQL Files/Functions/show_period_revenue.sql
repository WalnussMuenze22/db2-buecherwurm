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
    umsatz Number := 0;
BEGIN
    for zeile IN
        (
            SELECT  GESAMTPREIS FROM BESTELLUNG WHERE (Datum BETWEEN startDatum AND endDatum )
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Test' || 32 );
            umsatz := umsatz + zeile.GESAMTPREIS;
        end loop;
    return umsatz;
end;

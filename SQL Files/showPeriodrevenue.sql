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
--Problem war : Number war NULL und nicht als 0 initialisiert

/**
 * Funktion
 * Von : Caner Özer
 * Funktionsname:   create_surrogate_key
 * Beschreibung :   Erstellt einen Surrogate Key für die Bestellungen, um an der Bestellnummer direkt erkennen zu können, wann die Bestellung aufgegeben wurde.
 * [E]vent      :   Create Bestellung
 * [A]ction     :   Konkatination von Datum und fortlaufender Nummer zurückgeben
 */

CREATE SEQUENCE BESTELL_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
;

-- Funktion create_surrogate_key
CREATE OR REPLACE Function create_surrogate_key
    RETURN VARCHAR
IS
    surrogateKey VARCHAR(50);
BEGIN
    surrogateKey:= Sysdate || ' - ' || BESTELL_SEQ.nextval;
    RETURN surrogateKey;
END create_surrogate_key;
/

-- Setzt den generierten Primärschlüssel in die Tabelle Bestellung ein
CREATE OR REPLACE TRIGGER insert_generated_primary_key_into_bestellung
BEFORE INSERT ON Bestellung
FOR EACH ROW
DECLARE
BEGIN
    :NEW.BestellungID := create_surrogate_key;
END;
/





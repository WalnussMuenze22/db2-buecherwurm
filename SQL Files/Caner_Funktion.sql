CREATE SEQUENCE BESTELL_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
;

-- Funktion createSurrogateKey
CREATE OR REPLACE Function createSurrogateKey
RETURN VARCHAR
IS
surrogateKey VARCHAR(50);
BEGIN
surrogateKey:= Sysdate || ' - ' || BESTELL_SEQ.nextval;
RETURN surrogateKey;
END createSurrogateKey;
/

-- Setzt den generierten Primärschlüssel in die Tabelle Bestellung ein
CREATE OR REPLACE TRIGGER insertGeneratedPrimaryKeyIntoBestellung
BEFORE INSERT ON Bestellung
FOR EACH ROW
DECLARE
BEGIN
    :NEW.BestellungID := createSurrogateKey;
END;

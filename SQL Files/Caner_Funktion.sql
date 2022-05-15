
-- Funktion createSurrogateKey
CREATE OR REPLACE Function createSurrogateKey
RETURN VARCHAR
IS
surrogateKey VARCHAR(50);
BEGIN
surrogateKey:= Sysdate || ' - ' || BESTELL_SEQ.nextval;
RETURN surrogateKey;
END createSurrogateKey;

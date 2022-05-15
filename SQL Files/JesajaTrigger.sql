-- Autor: Jesaja Storm

CREATE OR REPLACE TRIGGER add_price_to_order
BEFORE INSERT ON Bestellposition
FOR EACH ROW
DECLARE
    v_Stueckpreis NUMBER;
    v_Steuersatz NUMBER;
BEGIN
    SELECT Preis, Steuersatz
    INTO v_Stueckpreis, v_Steuersatz
    FROM Artikel
    WHERE (:NEW.ArtikelID = Artikel.ArtikelID)
    ;
    
    :NEW.Stueckpreis := v_Stueckpreis;
    :NEW.Steuersatz := v_Steuersatz;
END;

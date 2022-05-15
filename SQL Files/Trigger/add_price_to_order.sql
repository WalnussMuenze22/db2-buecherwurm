/**
 * Trigger
 * Von : Jesaja Storm
 * Triggername  :   add_price_to_order
 * Beschreibung :   Fügt beim erstellen einer Bestellposition den aktuellen Produktpreis und den aktuellen Steuersatz in die Bestellposition ein.
 * [E]vent      :   Insert bei Bestellposition
 * [C]ondition  : 
 * [M]ode       :
 * [A]ction     :   Preis und Steuersatz von Artikel mit ArtikelID aus Bestellposition in die besagte Bestellposition eingfügen.
 *
 *
 */

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

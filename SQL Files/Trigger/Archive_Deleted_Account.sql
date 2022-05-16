/**
 * Trigger
 * Von : Denis Kliewer
 * Triggername  :   archive_deleted_account
 * Beschreibung :   Schreibt die Information, ob der Nutzer ncoh Aktiv ist in eine Log Tabelle
 * [E]vent      :   bei änderung des Attributs Aktiv in der Account Tabelle
 * [A]ction     :   Schreibe die Änderung in die Log Tabelle
 */

create or replace TRIGGER archive_deleted_account
	AFTER UPDATE
    OF Aktiv
	ON Account 
	FOR EACH ROW
DECLARE
    v_Aktiv NUMBER;
BEGIN
    IF :old.Aktiv = 0 and :new.aktiv = 1 then
	    v_Aktiv := 1;
	ELSIF :old.Aktiv = 1 and :new.aktiv = 0 then
	    v_Aktiv := 0;
    end if;    
	INSERT INTO LogAccountActive(ACCOUNTID, Datum, Aktiv) VALUES (:old.AccountID, SYSTIMESTAMP, v_Aktiv);
END;

--Testfall 1 - archive_deleted_account
SELECT * FROM Account;
SELECT * FROM LogAccountActive;
UPDATE Account SET aktiv = 0 WHERE accountid = 2;
SELECT * FROM Account;
SELECT * FROM LogAccountActive;

--Testfall 2 - archive_deleted_account
SELECT * FROM Account;
SELECT * FROM LogAccountActive;
UPDATE AccountSET aktiv = 1 WHERE accountid = 2;
SELECT * FROM Account;
SELECT * FROM LogAccountActive;
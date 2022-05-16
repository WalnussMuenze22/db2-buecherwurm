-- Archive Deleted Account

create or replace TRIGGER archive_deleted_account
	AFTER UPDATE
    OF Aktiv
	ON Account 
	FOR EACH ROW
DECLARE
    v_Aktiv NUMBER := 0;
BEGIN
        IF :new.Aktiv = 0 then
            v_Aktiv := 1;
        ELSE
            v_Aktiv := 0;
        end if;    

		INSERT INTO LogAccountActive(ACCOUNTID,Datum,Aktiv) VALUES (:old.AccountID, SYSTIMESTAMP,:new.Aktiv);
END;

--Test
SELECT *
FROM Account;
SELECT *
FROM LogAccountActive;
UPDATE Account
SET aktiv = 0
WHERE accountid = 2;
SELECT *
FROM Account;
SELECT *
FROM LogAccountActive;

SELECT *
FROM Account;
SELECT *
FROM LogAccountActive;
UPDATE Account
SET aktiv = 1
WHERE accountid = 2;
SELECT *
FROM Account;
SELECT *
FROM LogAccountActive;

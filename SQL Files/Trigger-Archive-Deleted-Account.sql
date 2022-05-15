-- Archive Deleted Account

CREATE OR REPLACE TRIGGER archive_deleted_account
	INSTEAD OF DELETE
	ON Account 
	FOR EACH ROW
DECLARE
	v_AccountId NUMBER;
BEGIN
		UPDATE Account 
		SET Aktiv=0 
		WHERE ACCOUNTID = :old.ACCOUNTID 
		RETURNING ACCOUNTID INTO v_AccountId;
		
		INSERT INTO LogAccountActive(ACCOUNTID,Datum,Aktiv) VALUES (v_AccountId, SYSTIMESTAMP,0);
END;

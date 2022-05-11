-- Archive Deleted Account
CREATE OR REPLACE TRIGGER archive_deleted_Account
BEFORE DELETE
ON Account
DECLARE
v_username VARCHAR(255);
BEGIN
SELECT user INTO v_username
FROM dual;
INSERT INTO account_archive(EMail,
							PasswortHash,
							AccountTyp,
							LetzerLogin,
							Aktiv
							) VALUES (:old.EMail,
							:old.PasswortHash,
							:old.AccountTyp,
							:old.LetzerLogin,
							:old.Aktiv);
END;

CREATE OR REPLACE TRIGGER archive_deleted_Address
BEFORE DELETE
ON Addresse
DECLARE
v_username VARCHAR(255);
BEGIN
SELECT user INTO v_username
FROM dual;
INSERT INTO account_archive(Vorname,
							Nachname,
							Strasse,
							Hausnummer,
							Postleitzahl,
							Ort
							) VALUES (:old.Vorname,
							:old.Nachname,
							:old.Strasse,
							:old.Hausnummer,
							:old.Postleitzahl,
							:old.Ort);
END;



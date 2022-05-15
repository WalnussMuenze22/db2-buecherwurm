-- Archive Deleted Account
CREATE OR REPLACE TRIGGER archive_deleted_account
BEFORE DELETE
ON Account
DECLARE
v_username VARCHAR(255);
BEGIN
SELECT user INTO v_username
FROM dual;
INSERT INTO account_archive(AccountID,
							EMail,
							PasswortHash,
							AccountTyp,
							LetzerLogin,
							Aktiv
							) VALUES (:old.AccountID,
							:old.EMail,
							:old.PasswortHash,
							:old.AccountTyp,
							:old.LetzerLogin,
							:old.Aktiv);
END;

CREATE OR REPLACE TRIGGER archive_deleted_address
BEFORE DELETE
ON Adresse
DECLARE
v_username VARCHAR(255);
BEGIN
SELECT user INTO v_username
FROM dual;
INSERT INTO adresse_archive(AdresseID,
							Vorname,
							Nachname,
							Strasse,
							Hausnummer,
							Postleitzahl,
							Ort
							) VALUES (:old.AdresseID,
							:old.Vorname,
							:old.Nachname,
							:old.Strasse,
							:old.Hausnummer,
							:old.Postleitzahl,
							:old.Ort);
END;

CREATE OR REPLACE TRIGGER archive_deleted_kunde
BEFORE DELETE
ON Kunde
DECLARE
v_username VARCHAR(255);
BEGIN
SELECT user INTO v_username
FROM dual;
INSERT INTO kunde_archive(KundeID,AccountID) VALUES (:old.KundeID,:old.AccountID);
END;

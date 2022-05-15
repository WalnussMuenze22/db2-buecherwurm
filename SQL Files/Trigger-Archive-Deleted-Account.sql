-- Archive Deleted Account
DROP TABLE kunde_archive;
DROP TABLE account_archive;
DROP TABLE address_archive;


CREATE TABLE kunde_archive(
    KundenID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    AccountID NUMBER
);

Create table account_archive(
    AccountID Number GENERATED ALWAYS AS IDENTITY Primary Key,
    EMAIL VARCHAR2(255),
    PASSWORTHASH VARCHAR2(255),
    ACCOUNTTYP VARCHAR2(30),
    LETZTERLOGIN TIMESTAMP(6)
);

CREATE TABLE adresse_archive(
    AdresseID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Vorname VARCHAR2(255),
    Nachname VARCHAR2(255),
    Strasse VARCHAR2(255),
    Hausnummer NUMBER,
    Postleitzahl NUMBER,
    Ort VARCHAR2(255),
    KundenID NUMBER NOT NULL
);

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
	INSERT INTO kunde_archive(KundenID,AccountID) VALUES (:old.KundenID,:old.AccountID);
END;

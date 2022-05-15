--Statistics
CREATE TYPE statistics AS OBJECT(
	MonatsID NUMBER,
	ArtikelID NUMBER,
	Umsatz NUMBER
);
					   
CREATE OR REPLACE FUNCTION show_statistics(typ IN NUMBER,monat IN NUMBER)
	RETURN statistics
	IS
		var_top_artikel statistics;
		var_monats_umsatz statistics;
	cursor top_artikel is
		SELECT statistics(MonatsID, ArtikelID, 0)
		FROM StatTopArtikel
		WHERE MonatsID = monat
		ORDER BY MonatsID DESC;
	cursor monats_umsatz is
		SELECT statistics(MonatsID, 0, Umsatz)
		FROM StatMonatsumsatz
		WHERE MonatsID = monat
		ORDER BY MonatsID DESC;
BEGIN
	open top_artikel;
	fetch top_artikel into var_top_artikel;

	open monats_umsatz;
	fetch monats_umsatz into var_monats_umsatz;

	if typ = 0 then
		if var_monats_umsatz.ArtikelID = 0 AND var_monats_umsatz.MonatsID = 0 AND var_monats_umsatz.Umsatz = 0 then
			raise_application_error(-2,'Keine Monatsumsätze');
		end if;
		close monats_umsatz;
		RETURN var_monats_umsatz;
	end if;
	if typ = 1 then
		if var_top_artikel.ArtikelID = 0 AND var_top_artikel.MonatsID = 0 AND var_top_artikel.Umsatz = 0 then
			raise_application_error(-2,'Keine Top-Artikel');
		end if;
		close top_artikel;
		RETURN var_top_artikel;
	end if;
	RETURN statistics(0,0,0);
END;
COMMIT;

BEGIN
	--Function Test
	DBMS_OUTPUT.PUT_LINE('Statistiken Monatsumsätze: '  ||  show_statistics(0,202204,1));
	DBMS_OUTPUT.PUT_LINE('Statistiken Top-Artikel: '  ||  show_statistics(1,202204,1));
END;

BEGIN;
	--Trigger Test
	SELECT *
	FROM ACCOUNT
	WHERE ACCOUNTID = 2;
	
	SELECT *
	FROM ACCOUNT_ARCHIVE;
	
	DELETE FROM ACCOUNT 
	WHERE ACCOUNTID = 2;
	
	SELECT *
	FROM ACCOUNT
	WHERE ACCOUNTID = 2;
	
	SELECT *
	FROM ACCOUNT_ARCHIVE;
	
END;

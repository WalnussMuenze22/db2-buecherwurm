-- Bücher --

INSERT INTO BuchInformationen (
        Titel,
        Preis,
        Steuersatz,
        Beschreibung,
        ISBN,
        ErscheinungsDatum,
        Sprache,
        AnzahlVerfuegbar,
        Mindestbestand,
        AnzahlVerkauft,
        AnzahlSeiten,
        Verlag,
        AutorenListe
) VALUES (
        'Die Känguru-Chroniken',
        10.99,
        7,
        'Frisch Frech und völlig Absurd',
        9783548372570,
        DATE '2009-03-11',
        'DE',
        10,
        8,
        0,
        272,
        'Ullstein',
        'Marc-Uwe Kling'
);


INSERT INTO BuchInformationen (
        Titel,
        Preis,
        Steuersatz,
        Beschreibung,
        ISBN,
        ErscheinungsDatum,
        Sprache,
        AnzahlVerfuegbar,
        Mindestbestand,
        AnzahlVerkauft,
        AnzahlSeiten,
        Verlag,
        AutorenListe
) VALUES (
        'Die Känguru-Comics 1: Also ICH könnte das besser',
        22.00,
        7,
        'Das Känguru und Marc-Uwe kommentieren den alltäglichen Wahnsinn auf ZEIT online – und zwar als Comicfiguren!',
        9783551728289,
        DATE '2022-03-20',
        'DE',
        24,
        20,
        0,
        224,
        'Carlsen',
        'Marc-Uwe Kling#Bernd Kissel'
);


INSERT INTO BuchInformationen (
        Titel,
        Preis,
        Steuersatz,
        Beschreibung,
        ISBN,
        ErscheinungsDatum,
        Sprache,
        AnzahlVerfuegbar,
        Mindestbestand,
        AnzahlVerkauft,
        AnzahlSeiten,
        Verlag,
        AutorenListe
) VALUES (
        'Lustiges Taschenbuch - Donald gibt nicht auf',
        6.00,
        7,
        'Vorgeschichte, Onkel Donald und die Unglücksschule, Donald und der "Fliegende Schotte", Donald und das Filmfestival, Onkel Dagobert un der zauberspiegel',
        null,
        DATE '1969-01-01',
        'DE',
        10,
        3,
        1,
        250,
        'Egmont Ehapa Media GmbH',
        'Gian Giacomo Dalmasso#Guido Martina#Romano Scarpa'
);


INSERT INTO BuchInformationen (
        Titel,
        Preis,
        Steuersatz,
        Beschreibung,
        ISBN,
        ErscheinungsDatum,
        Sprache,
        AnzahlVerfuegbar,
        Mindestbestand,
        AnzahlVerkauft,
        AnzahlSeiten,
        Verlag,
        AutorenListe
) VALUES (
        '1984 : Neu übersetzt von Jan Strümpel',
        6.95,
        7,
        'London, 1984: Winston Smith, Geschichtsfälscher im Staatsdienst, verliebt sich in die schöne und geheimnisvolle Julia.' ||
        'Gemeinsam beginnen sie, die totalitäre Welt infrage zu stellen, als Teil derer sie bisher funktioniert haben.' ||
        'Doch bereits ihre Gedanken sind Verbrechen, und der Große Bruder richtet seinen stets wachsamen Blick auf jeden potenziellen Dissidenten.' ||
        'George Orwells Vision eines totalitären Staats, in dem Cyberüberwachung, Geschichtsrevisionismus und Gedankenpolizei den Alltag gläserner Bürger bestimmen, hat wie keine andere Dystopie bis heute nur an Brisanz gewonnen.',
        3730609769,
        DATE '2021-01-18',
        'DE',
        20,
        10,
        30,
        400,
        'Anaconda Verlag',
        'George Orwell'
);




-- Accounts --

INSERT INTO Account (
        Email,
        PasswortHash,
        AccountTyp,
        LetzterLogin,
        Aktiv
) VALUES (
        'test@example.com',
        '$2a$10$/w/x/y/z/A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z',
        'Kunde',
        DATE '2022-01-01',
        1
);


INSERT INTO Account (
        Email,
        PasswortHash,
        AccountTyp,
        LetzterLogin,
        Aktiv
) VALUES (
        'test2@example.com',
        '$2admz/w/x/y/z/A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z',
        'Kunde',
        DATE '2021-01-01',
        1
);

INSERT INTO Account (
        Email,
        PasswortHash,
        AccountTyp,
        LetzterLogin,
        Aktiv
) VALUES (
        'sven.heiter@smail.th-koeln.de',
        '$2aqrs/w/x/y/z/A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z',
        'Kunde',
        DATE '2020-01-01',
        1
);




-- Kunden --

INSERT INTO Kunde (AccountID) VALUES (1);

INSERT INTO Kunde (AccountID) VALUES (2);

INSERT INTO Kunde (AccountID) VALUES (3);




-- Adressen --

INSERT INTO Adresse (
        Vorname,
        Nachname,
        Strasse,
        Hausnummer,
        Postleitzahl,
        Ort,
        KundenID
) VALUES (
        'Stefanie',
        'Rothschild',
        'Grosse Praesidenten Str. ',
        61,
        67752,
        'Oberweiler-Tiefenbach',
        1
);


INSERT INTO Adresse (
        Vorname,
        Nachname,
        Strasse,
        Hausnummer,
        Postleitzahl,
        Ort,
        KundenID
) VALUES (
        'Sebastian',
        'Adler',
        'Messedamm 42',
        42,
        01194,
        'Dresden',
        2
);


INSERT INTO ADRESSE (
        Vorname,
        Nachname,
        Strasse,
        Hausnummer,
        Postleitzahl,
        Ort,
        KundenID
) VALUES (
        'Sven',
        'Heiter',
        'Entenhausenerstraße',
        '4',
        '51645',
        'Gummersbach',
        3
);




-- Bestellungen mit Bestellposition --

/* Bestellung 1 (Offen)
 * 1 mal Känguru Comics; MwSt7; Stückpreis 22€
 * 2 mal LTB - Donald gibt nicht auf; MwSt7; Stückpreis 6€
 * Gesamtpreis: 34€
 */
INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID,
        Gesamtpreis
) VALUES (
        DATE '2022-03-01',
        'offen',
        3,
        3,
        3,
        34.00
);

INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        2,
        (SYSDATE || ' - ' || 1),
        22.00,
        7,
        1
);

INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        3,
        (SYSDATE || ' - ' || 1),
        6.00,
        7,
        2
);


/* Bestellung 2 (zugestellt)
 * 1 mal Känguru Chroniken; MwSt7; Stückpreis 10.99€
 * 5 mal LTB - Donald gibt nicht auf; MwSt7; Stückpreis 6€
 * 3 mal George Orwell 1984; MwSt7; Stückpreis 6.95€
 * Gesamtpreis: 61.84€
 */

INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID,
        Gesamtpreis
) VALUES (
        DATE '2022-03-02',
        'zugestellt',
        3,
        3,
        3,
        61.84
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        1,
        (SYSDATE || ' - ' || 2),
        10.99,
        7,
        1
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        3,
        (SYSDATE || ' - ' || 2),
        6.00,
        7,
        5
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        4,
        (SYSDATE || ' - ' || 2),
        6.95,
        7,
        3
);



/* Bestellung 3 (editierbar)
 * 1 mal LTB - Donald gibt nicht auf; MwSt7; Stückpreis 6€
 * Gesamtpreis: ?
 */

INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID
) VALUES (
        DATE '2022-03-02',
        'editierbar',
        3,
        3,
        3
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        3,
        (SYSDATE || ' - ' || 3),
        6.00,
        7,
        1
);



/* Bestellung 4 (offen)
 * 4 mal LTB - Donald gibt nicht auf; MwSt7; Stückpreis 6€
 * Gesamtpreis: ?
 */

INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID
) VALUES (
        add_months(SYSDATE, -1),
        'offen',
        3,
        3,
        3
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        3,
        (SYSDATE || ' - ' || 4),
        6.00,
        7,
        4
);


COMMIT;






















DECLARE
    v_test_num1 NUMBER;
BEGIN
    -- Test Funktionen
    
    -- show_period_revenue Test1
    IF (show_period_revenue(Date '2020-01-01', DATE '2023-01-01') = 95.84) THEN
        DBMS_OUTPUT.PUT_LINE('show_period_revenue Test1 passed');
    ELSE
        raise_application_error(-20123, 'show_period_revenue Test1 failed: expected ' || 95.84 || ' but got ' || show_period_revenue(Date '2020-01-01', DATE '2023-01-01'));
    END IF;
    
    
    -- show_period_revenue Test2
    IF (show_period_revenue(Date '2022-03-02', DATE '2022-03-02') = 61.84) THEN
        DBMS_OUTPUT.PUT_LINE('show_period_revenue Test2 passed');
    ELSE
        raise_application_error(-20123, 'show_period_revenue Test2 failed: expected ' || 61.84 || ' but got ' || show_period_revenue(Date '2022-03-02', DATE '2022-03-02'));
    END IF;
    
    
    
    
    -- send_emails Test1: E-Mail senden
    INSERT INTO Account (
        Email,
        PasswortHash,
        AccountTyp,
        LetzterLogin,
        Aktiv
    ) VALUES (
        'testsendEmail@example.com',
        '$2a$10$/w/x/y/z/A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z',
        'Kunde',
        sysdate  - 182,
        1
    );


    -- send_emails Test2: E-Mail wird nicht gesendet
    INSERT INTO Account (
        Email,
        PasswortHash,
        AccountTyp,
        LetzterLogin,
        Aktiv
    ) VALUES (
        'testDontSendEmail@example.com',
        '$2a$10$/w/x/y/z/A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z',
        'Kunde',
        sysdate,
        1
    );

    BEGIN
        send_emails();
    END;
    
    
    
    
    -- adjust_minimum_Stock Test1
    INSERT INTO Bestellposition
    (ArtikelID, BestellungID, Stueckpreis, Steuersatz, Menge)
    VALUES (3, (SYSDATE || ' - ' || 4), 6.00, 7, 36)
    ;
    
    adjust_minimum_stock;
    
    SELECT MindestBestand
    INTO v_test_num1
    FROM Artikel
    WHERE ArtikelID = 3
    ;
    
    IF (v_test_num1 = 16) THEN
        DBMS_OUTPUT.PUT_LINE('adjust_minimum_Stock Test1 passed');
    ELSE
        raise_application_error(-20123, 'adjust_minimum_Stock Test1 failed: expected ' || 16 || ' but got ' || v_test_num1);
    END IF;
    
    
    -- adjust_minimum_Stock Test2
    INSERT INTO Bestellposition
    (ArtikelID, BestellungID, Stueckpreis, Steuersatz, Menge)
    VALUES (3, (SYSDATE || ' - ' || 4), 6.00, 7, 40)
    ;
    
    adjust_minimum_stock;
    
    SELECT MindestBestand
    INTO v_test_num1
    FROM Artikel
    WHERE ArtikelID = 3
    ;
    
    IF (v_test_num1 = 32) THEN
        DBMS_OUTPUT.PUT_LINE('adjust_minimum_Stock Test2 passed');
    ELSE
        raise_application_error(-20123, 'adjust_minimum_Stock Test2 failed: expected ' || 32 || ' but got ' || v_test_num1);
    END IF;
    
    
    
    
    -- create_surrogate_key Test1: Key 'sysdate - 3' existiert
    SELECT COUNT(*) AS keysWithValue
    INTO v_test_num1
    FROM Bestellung
    WHERE BestellungID = (sysdate || ' - 3');
    
    IF (v_test_num1 = 1) THEN
    DBMS_OUTPUT.PUT_LINE('create_surrogate_key Test1 passed');
    ELSE
    raise_application_error(-20123, 'create_surrogate_key Test1 failed: key ' || (sysdate || ' - 3') || ' not found!');
    END IF;
    
    
    -- create_surrogate_key Test2: Key 'sysdate - 4' existiert    
    SELECT COUNT(*) AS keysWithValue
    INTO v_test_num1
    FROM Bestellung
    WHERE BestellungID = (sysdate || ' - 4');
    
    IF (v_test_num1 = 1) THEN
        DBMS_OUTPUT.PUT_LINE('create_surrogate_key Test2 passed');
    ELSE
        raise_application_error(-20123, 'create_surrogate_key Test2 failed: key ' || (sysdate || ' - 4') || ' not found!');
    END IF;
    
    
    
    
    









































    
    
    
    -- Test Trigger
    
    -- reduce_stock Test1: Bestellung von editierbar auf offen setzen
    
    UPDATE Bestellung
    SET Status = 'offen'
    WHERE BestellungID = (SYSDATE || ' - ' || 3)
    ;
    
    SELECT AnzahlVerfuegbar
    INTO v_test_num1
    FROM Artikel
    WHERE ArtikelID = 3
    ;
    
    IF (v_test_num1 = 9) THEN
        DBMS_OUTPUT.PUT_LINE('reduce_stock Test1 passed');
    ELSE
        raise_application_error(-20123, 'reduce_stock Test1 failed: expected ' || 9 || ' but got ' || v_test_num1);
    END IF;
    
    
    -- reduce_stock Test2: Bestellung von editierbar auf offen setzen
    
    UPDATE Bestellung
    SET Status = 'zugestellt'
    WHERE BestellungID = (SYSDATE || ' - ' || 3)
    ;
    
    SELECT AnzahlVerfuegbar
    INTO v_test_num1
    FROM Artikel
    WHERE ArtikelID = 3
    ;
    
    IF (v_test_num1 = 9) THEN
        DBMS_OUTPUT.PUT_LINE('reduce_stock Test2 passed');
    ELSE
        raise_application_error(-20123, 'reduce_stock Test2 failed: expected ' || 9 || ' but got ' || v_test_num1);
    END IF;
    
    
    
    
    -- account_logging Test1: Create Account
    Insert into Account (EMail, PasswortHash, AccountTyp, LETZTERLOGIN,  Aktiv) values ('test4@example.com', 'test', 'test', SYSDATE, 1);

    -- account_logging Test2: Update Email for Account
    UPDATE ACCOUNT SET EMail = 'leopetersberg@gmail.com' WHERE AccountID = 1;
    
    -- account_logging Test3: Update Aktiv for Account
    UPDATE ACCOUNT SET AKTIV = 0 WHERE AccountID = 1;
    
    
    
    
    
    
    
    
    
    
    

    
    -- add_to_stock_order Test1:
    --Die Känguru-Chroniken 
    --Midestanzahl ist 8
    --Vefügbar von 10 auf 5 setzen
    --Es sollten 5 (4.6) Känguru-Chroniken nachbestellt werden
    UPDATE Artikel SET Mindestbestand = 8 WHERE ArtikelID = 1;
    UPDATE Artikel SET AnzahlVerfuegbar = 5 WHERE ArtikelID = 1;
    
    SELECT Anzahl
    INTO v_test_num1
    FROM Nachbestellung
    WHERE (
        ArtikelID = 1
    );
    
    IF (v_test_num1 = 5) THEN
        DBMS_OUTPUT.PUT_LINE('add_to_stock_order Test1 passed');
    ELSE
        raise_application_error(-20123, 'add_to_stock_order Test1 failed: expected ' || 5 || ' but got ' || v_test_num1);
    END IF;
    
    -- add_to_stock_order Test2:
    --Die Känguru-Comics 1
    --Midestanzahl ist 20
    --Vefügbar von 24 auf 20 setzen 
    --Es sind 2 bereits auf der Nachbestellungen Liste
    --Die Nachbestellen Liste sollte auf 4 erhöt werden 
    UPDATE Artikel SET Mindestbestand = 20 WHERE ArtikelID = 2;
    UPDATE Artikel SET AnzahlVerfuegbar = 20 WHERE ArtikelID = 2;
    
    SELECT COUNT(*)
    INTO v_test_num1
    FROM Nachbestellung
    WHERE (
        ArtikelID = 2
    );
    
    IF (v_test_num1 = 0) THEN
        DBMS_OUTPUT.PUT_LINE('add_to_stock_order Test2 passed');
    ELSE
        raise_application_error(-20123, 'add_to_stock_order Test2 failed!');
    END IF;




    --archive_deleted_account Test 1:
    UPDATE Account SET aktiv = 0 WHERE accountid = 2;
    SELECT count(*) 
    INTO v_test_num1
    FROM LogAccountActive;


    --archive_deleted_account Test 2:
    UPDATE Account SET aktiv = 1 WHERE accountid = 2;
    SELECT COUNT(*) 
    INTO v_test_num1
    FROM LogAccountActive;



END;

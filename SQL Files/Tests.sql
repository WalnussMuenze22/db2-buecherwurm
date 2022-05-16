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
        DBMS_OUTPUT.PUT_LINE('show_period_revenue Test1 passed');
    ELSE
        raise_application_error(-20123, 'show_period_revenue Test1 failed: expected ' || 8 || ' but got ' || v_test_num1);
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
        DBMS_OUTPUT.PUT_LINE('show_period_revenue Test2 passed');
    ELSE
        raise_application_error(-20123, 'show_period_revenue Test2 failed: expected ' || 16 || ' but got ' || v_test_num1);
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








END;

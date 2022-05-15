
-- Testfälle Funktion send_emails(): 

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
        sysdate  - 182,
        1
);


BEGIN
    send_emails();
END;




-- Testfälle Trigger account_logging: 
set serveroutput on size 30000;
Insert into Account (EMail, PasswortHash, AccountTyp, LETZTERLOGIN,  Aktiv) values ('test@example.com', 'test', 'test', SYSDATE, 1);
UPDATE ACCOUNT SET EMail = 'leopetersberg@gmail.com' WHERE AccountID = 1;
UPDATE ACCOUNT SET AKTIV = 0 WHERE AccountID = 1;
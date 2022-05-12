create trigger ACCOUNTLOGGING
    after insert or update
    on ACCOUNT
    for each row
Declare
    Datetime varchar2(20);
    DBUSer varchar2(20);
Begin
    Datetime := TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS');
    SELECT SYS_CONTEXT ('USERENV', 'SESSION_USER') into DBUSer FROM DUAL;
    -- insert
    IF INSERTING THEN
        dbms_output.put_line( Datetime || ' Es wurde ein Account erstellt: DB-User: ' || DBUSer ||  'AccountID: '||  :new.AccountID || ' Account E-Mail: ' || :new.EMail);
    -- update
    ELSIF UPDATING THEN
        IF :OLD.AKTIV = 1 AND :NEW.AKTIV = 0 THEN
            -- archiviert
            dbms_output.put_line( Datetime || ' Es wurde ein Account archiviert: DB-User: ' || DBUSer ||  'AccountID: '||  :old.AccountID || ' Account E-Mail: ' || :old.EMail);
        ELSE
            -- geändert
            dbms_output.put_line( Datetime || ' Es wurde ein Account geändert: DB-User: ' || DBUSer ||  'AccountID: '||  :new.AccountID || ' Account E-Mail: ' || :new.EMail);
        END IF;
    end if;
end;
/



-- Testfälle
Insert into ACCount (EMail, PasswortHash, AccountTyp, LETZTERLOGIN,  Aktiv) values ('test@example.com', 'test', 'test', SYSDATE, 1);
UPDATE ACCOUNT SET EMail = 'leopetersberg@gmail.com' WHERE AccountID = 1;
UPDATE ACCOUNT SET AKTIV = 0 WHERE AccountID = 1;
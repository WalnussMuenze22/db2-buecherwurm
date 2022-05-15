/**
 * Trigger
 * Von : Leo Petersberg
 * Triggername  :   account_logging
 * Beschreibung :   Wird ausgeführt, wenn ein Account erstellt, verändert oder archiviert wird
 * [E]vent      :   Create or Update Account
 * [C]ondition  :   Create or Update or Archive
 * [A]ction     :   Logge Änderung auf Konsole mit DBUser, AccountID und E-Mail
 */

create or replace trigger account_logging
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
        dbms_output.put_line( Datetime || ' Es wurde ein Account erstellt: DB-User: ' || DBUSer ||  ' AccountID: '||  :new.AccountID || ' Account E-Mail: ' || :new.EMail);
    -- update
    ELSIF UPDATING THEN
        IF :OLD.AKTIV = 1 AND :NEW.AKTIV = 0 THEN
            -- archiviert 
            dbms_output.put_line( Datetime || ' Es wurde ein Account archiviert: DB-User: ' || DBUSer ||  ' AccountID: '||  :old.AccountID || ' Account E-Mail: ' || :old.EMail);
        ELSE
            -- geändert
            dbms_output.put_line( Datetime || ' Es wurde ein Account geändert: DB-User: ' || DBUSer ||  ' AccountID: '||  :new.AccountID || ' Account E-Mail: ' || :new.EMail);
        END IF;
    end if;
end;
/


/**
 * Funktion
 * Von : Leo Petersberg
 * Funktionname :   send_emails
 * Beschreibung :   Sendet Marketing E-Mails an Kunden, die lange nicht mehr eingeloggt waren
 * [E]vent      :   1x am Tag
 * [C]ondition  :   Vor einem halben Jahr das letzte mal eingeloggt
 * [A]ction     :   Sende Marketing E-Mail
 */

create procedure send_emails AS
    CURSOR accounts_cursor is (
        -- E-Mail-Adresse von Kunden, die seit zwichen 182 und 183 Tagen nicht eingelogt waren und dazu den Namen des Kunden aus seiner letzten Bestellung
        SELECT a.EMAIL, Adresse.NACHNAME
        FROM Account a
            join Kunde ku on a.ACCOUNTID = ku.ACCOUNTID
            join Bestellung on ku.KUNDENID = BESTELLUNG.KUNDENID
            join Adresse on BESTELLUNG.RECHNUNGSADRESSEID = ADRESSE.ADRESSEID
        WHERE   TO_DATE(sysdate) - cast(LETZTERLOGIN as date) >= 182
            AND TO_DATE(sysdate) - cast(LETZTERLOGIN as date) <  183
            AND BESTELLUNG.DATUM =
                --Datum der letzten Bestellung des jeweiligen Kunden
                (SELECT MAX(Datum)
                FROM Bestellung
                WHERE Bestellung.KUNDENID = ku.KUNDENID)
    );
    account_name ADRESSE.NACHNAME%type;
    account_email ACCOUNT.EMAIL%type;
    --l_mail_conn UTL_SMTP.connection;
Begin
    open accounts_cursor;
    Loop
        FETCH accounts_cursor into account_email, account_name;
        EXIT when accounts_cursor%notfound;
        dbms_output.put_line('Sending mail to ' || account_email || ' (' || account_name || ')');

        --E-Mail senden vom TH Server nicht möglich, aufgrund Berechtigungen: ORA-24247: Netzwerkzugriff von Access Control-Liste (ACL) abgelehnt
        --l_mail_conn := UTL_SMTP.open_connection('web13.alfahosting-server.de', 25);
        --UTL_SMTP.helo(l_mail_conn, 'studidb.gm.th-koeln.de');
        --UTL_SMTP.mail(l_mail_conn, 'buecherwurm@leopebe.de');
        --UTL_SMTP.rcpt(l_mail_conn, account_email);

        --UTL_SMTP.open_data(l_mail_conn);
        --UTL_SMTP.write_data(l_mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'To: ' || account_email || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'From: ' || 'buecherwurm@leopebe.de' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Subject: Wir vermissen Sie! ' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Sehr geerthe/r  Frau/Herr ' || account_name || ',' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'sie haben uns schon lange nicht mehr besucht. Schauen sie mal wieder bei uns vorbei und sehen sie sich unsere aktuellen Angebote an. ' || account_name || ',' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Wir wünschen Ihnen einen schönen Tag.' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Mit freundlichen Grüßen,' || UTL_TCP.crlf);
        --UTL_SMTP.write_data(l_mail_conn, 'Ihr Bücherwurm Team' || UTL_TCP.crlf);

        --UTL_SMTP.write_data(l_mail_conn, p_message || UTL_TCP.crlf || UTL_TCP.crlf);
        --UTL_SMTP.close_data(l_mail_conn);
        --UTL_SMTP.quit(l_mail_conn);
    end loop;
    close accounts_cursor;
end;
/



-- Scheduler-Job für den Senden der E-Mails registrieren
BEGIN
    --DBMS_SCHEDULER.DROP_JOB ('send_emails_every_day');
    
    DBMS_SCHEDULER.CREATE_JOB (
        comments           =>  'Versendet jeden Tag E-Mails an Accounts, die ein halbes Jahr nicht eingelogggt waren.',
        
        start_date         =>   SYSTIMESTAMP,
        end_date           =>   NULL,
        repeat_interval    =>  'FREQ = DAILY; INTERVAL = 1', /* wird täglich ausgeführt */
        
        job_name           =>  'send_emails_every_day',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'send_emails',
        
        auto_drop          =>   FALSE,
        enabled            =>   TRUE
    );
END;

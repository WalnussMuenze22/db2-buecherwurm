create procedure send_emails AS
    CURSOR accounts_cursor is (
        SELECT ACCOUNT.EMAIL
        FROM Account
        WHERE (TO_DATE(sysdate) - cast(LETZTERLOGIN as date) )> 182
        AND   TO_DATE(sysdate) - cast(LETZTERLOGIN as date) < 500
    );
    account_name ADRESSE.NACHNAME%type;
    account_email ACCOUNT.EMAIL%type;
    l_mail_conn UTL_SMTP.connection;
Begin
    open accounts_cursor;
    Loop
        FETCH accounts_cursor into account_email;
        EXIT when accounts_cursor%notfound;
        SELECT ADRESSE.NACHNAME INTO account_name FROM ADRESSE Join Bestellung on ADRESSE.ADRESSEID = BESTELLUNG.RECHNUNGSADRESSEID;

        --E-Mail senden vom TH Server nicht möglich, aufgrund Berechtigungen: ORA-24247: Netzwerkzugriff von Access Control-Liste (ACL) abgelehnt
        --l_mail_conn := UTL_SMTP.open_connection('web13.alfahosting-server.de', 25);
        --UTL_SMTP.helo(l_mail_conn, 'web13.alfahosting-server.de');
        --UTL_SMTP.mail(l_mail_conn, 'buecherwurm@leopebe.de');
        --UTL_SMTP.rcpt(l_mail_conn, account_email);
        --UTL_SMTP.data(l_mail_conn, 'Dies ist ein Test.' || UTL_TCP.crlf || UTL_TCP.crlf);
        --UTL_SMTP.quit(l_mail_conn);
    end loop;
    close accounts_cursor;
end;
/
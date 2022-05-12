-- Oracle-Syntax
--PLSQL procedure for sending emails to all acccounts where last Login is older than a half year
CREATE or replace procedure send_emails AS
DECLARE
    CURSOR accounts_cursor is (
        SELECT DISTINCT ACCOUNT.EMAIL, ADRESSE.NACHNAME
        FROM Account
        join KUNDE on ACCOUNT.ACCOUNTID = KUNDE.ACCOUNTID
        JOIN ADRESSE on KUNDE.KUNDENID = ADRESSE.KUNDENID
        WHERE TO_DATE(LETZTERLOGIN) < TO_DATE(sysdate) - 182
        AND TO_DATE(LETZTERLOGIN) > TO_DATE(sysdate) - 183
    );
    account_name ADRESSE.NACHNAME%type;
    account_email ACCOUNT.EMAIL%type;
    l_mail_conn UTL_SMTP.connection;
Begin
    open accounts_cursor;
    Loop
        FETCH accounts_cursor into account_name, account_email;
        EXIT when accounts_cursor%notfound;
        l_mail_conn := UTL_SMTP.open_connection('web13.alfahosting-server.de', 25);
        UTL_SMTP.helo(l_mail_conn, 'web13.alfahosting-server.de');
        UTL_SMTP.mail(l_mail_conn, 'buecherwurm@leopebe.de');
        UTL_SMTP.rcpt(l_mail_conn, account_email);
        UTL_SMTP.data(l_mail_conn, 'Dies ist ein Test.' || UTL_TCP.crlf || UTL_TCP.crlf);
        UTL_SMTP.quit(l_mail_conn);
    end loop;
    close accounts_cursor;
end;


-- Noch nicht fertig
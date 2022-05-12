-- Oracle-Syntax
--PLSQL procedure for sending emails to all acccounts where last Login is older than a half year
CREATE or replace procedure send_emails
DECLARE 
    accounts_cursor CURSOR FOR SELECT * FROM Account WHERE last_login < sysdate - 0.5;
    account_name account.name%type;
    account_email account.email%type;
Begin
    open accounts_cursor;
    fetch accounts_cursor into account_name, account_email;
    while accounts_cursor%FOUND do
        l_mail_conn := UTL_SMTP.open_connection('web13.alfahosting-server.de', '25');
        UTL_SMTP.helo(l_mail_conn, 'web13.alfahosting-server.de');
        UTL_SMTP.mail(l_mail_conn, 'buecherwurm@leopebe.de');
        UTL_SMTP.rcpt(l_mail_conn, account_email);
        UTL_SMTP.data(l_mail_conn, 'Dies ist ein Test.' || UTL_TCP.crlf || UTL_TCP.crlf);
        UTL_SMTP.quit(l_mail_conn);
        fetch accounts_cursor into account_name, account_email;
    end loop;
    close accounts_cursor;
    del accounts_cursor;
end;


-- Noch nicht fertig
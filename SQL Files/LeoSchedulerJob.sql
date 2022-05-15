
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

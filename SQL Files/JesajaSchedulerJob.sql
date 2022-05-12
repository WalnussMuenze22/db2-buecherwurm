-- Autor: Jesaja Storm

BEGIN
    --DBMS_SCHEDULER.DROP_JOB ('adjust_mininum_stock_every_month');
    
    DBMS_SCHEDULER.CREATE_JOB (
        comments           =>  'Passt den Mindestbestand anhand der Verkaufszahlen an',
        
        start_date         =>   SYSTIMESTAMP,
        end_date           =>   NULL,
        repeat_interval    =>  'FREQ=MONTHLY;BYMONTHDAY=1', /* Wird an jedem 1. eines Monat ausgeführt */
        
        job_name           =>  'adjust_mininum_stock_every_month',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'ADJUST_MINIMUM_STOCK',
        
        auto_drop          =>   FALSE,
        enabled            =>   TRUE
    );
END;

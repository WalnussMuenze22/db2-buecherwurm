--Statistics

execute DBMS_JOB.SUBMIT(job=>:showStatistics, 
                        what=>'select * FROM showStatistics; end;', 
                        next_date=>SYSDATE,
                        interval=>'SYSDATE+1'); 

execute DBMS_SCHEDULER.CREATE_JOB (job_name => 'showStatistics',
								job_type => 'PLSQL_BLOCK',
								job_action => 'select * FROM showStatistics; end;',
								start_date => SYSDATE,
								repeat_interval => 'FREQ = MONTHLY; INTERVAL = 1',
								auto_drop => FALSE,
								enabled => TRUE);

execute DBMS_SCHEDULER.CREATE_SCHEDULE(repeat_interval => 'FREQ=MONTHLY;BYHOUR=00:00',
                       start_date => to_timestamp_tz('2022-05-11 Europe/Berlin', 'YYYY-MM-DD TZR'),
                       schedule_name => 'MONTHLYSCHEDULE');
					   
CREATE OR REPLACE FUNCTION ShowStatistics
RETURN VARCHAR(255)
IS
cvarchar VARCHAR(255);
cursor c1 is
SELECT *
FROM StatTopArtikel;

BEGIN

open c1;
fetch c1 into cvarchar;

if c1%notfound then
	cvarchar := 'Keine Statistik';
end if;

close c1;

RETURN cvarchar;

EXCEPTION
WHEN OTHERS THEN
	raise_application_error(-1,'Error '||SQLCODE||' '||SQLERRM);
END;
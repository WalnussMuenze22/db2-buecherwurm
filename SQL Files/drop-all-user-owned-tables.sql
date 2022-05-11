DECLARE
    CURSOR drop_table_names IS
        SELECT TABLE_NAME
        FROM USER_TABLES
    ;
    confirmDropInput VARCHAR(10);
BEGIN
    dbms_output.put_line('Do you really want to drop the following tables?');
    dbms_output.put_line('');
    dbms_output.put_line('-------------------------------------------------');

    dbms_output.put_line('');
    FOR table_row IN drop_table_names LOOP
        dbms_output.put_line(table_row.TABLE_NAME);
    END LOOP;
    
    confirmDropInput := '&action';
    
    dbms_output.put_line('');
    dbms_output.put_line('');
    if (confirmDropInput = 'DROPALL') THEN
        FOR table_row IN drop_table_names LOOP
            EXECUTE IMMEDIATE 'DROP TABLE ' || table_row.TABLE_NAME || ' CASCADE CONSTRAINTS';
            dbms_output.put_line('DROPPED TABLE ' || table_row.TABLE_NAME);
        END LOOP;
            dbms_output.put_line('');
        dbms_output.put_line('DROPPED ALL USER TABLES!');
    ELSE
        dbms_output.put_line('If you wanna drop all listed tables rerun the script and type DROPALL');
    END IF;
END;
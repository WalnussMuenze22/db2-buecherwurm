<?php
    

    require_once $_SERVER["DOCUMENT_ROOT"] . "/php/databaseConnection.php";
    //$stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "BEGIN :umsatz := show_period_revenue(first_day(sysdate-interval '1' month), last_day(sysdate-interval '1' month)); END;");
    $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "BEGIN :umsatz := show_period_revenue(sysdate-30, sysdate+1); END;");
    oci_bind_by_name($stmt, ":umsatz", $umsatz, -1, SQLT_INT);
    oci_execute($stmt);




?>

<!DOCTYPE HTML>
<html lang="de">
    <head>
        <meta charset="UTF-8">
        <title>Monatsumsatz</title>
    </head>
    <body>
        <h1>Monatsumsatz</h1>
        
        <p>Der Umsatz der letzten 30 Tage beträgt <?php echo $umsatz;?>€.</p>
    </body>
</html>

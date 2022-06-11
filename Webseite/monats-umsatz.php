<?php
    require_once $_SERVER["DOCUMENT_ROOT"] . "/php/databaseConnection.php";
    $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "BEGIN :umsatz := show_period_revenue(sysdate-30, sysdate+1); END;");
    oci_bind_by_name($stmt, ":umsatz", $umsatz, -1, SQLT_INT);
    oci_execute($stmt);
?>

<!doctype html>
<html lang="de">
    <?php include 'head.php' ?>
	<body >
        <?php include 'header.php' ?>
    <body>
    <div style="text-align: center;">
            <h1>Monatsumsatz</h1>
        
            <p>Der Umsatz der letzten 30 Tage beträgt <?php echo $umsatz;?>€.</p>
        </div>
        <?php include 'footer.php' ?>
    </body>
</html>

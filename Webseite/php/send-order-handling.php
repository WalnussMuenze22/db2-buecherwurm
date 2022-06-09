
<?php

require_once($_SERVER["DOCUMENT_ROOT"] . "/php/databaseConnection.php");

require_once $_SERVER["DOCUMENT_ROOT"] . "/php/WarenkorbFunctions.php";
$bestellungID = WarenkorbFunctions::getOrCreateWarenkorb();
$stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "Update bestellung set status = 'offen' where bestellungid = :bestellungID");
oci_bind_by_name($stmt, ":bestellungID", $bestellungID);
oci_execute($stmt);


header("Location: /index.php");
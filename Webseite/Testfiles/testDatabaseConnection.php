<?php

require_once $_SERVER["DOCUMENT_ROOT"] . "/db2-buecherwurm/Webseite/php/databaseConnection.php";

if(DatabaseConnection::getDatabaseConnection()){
    echo "Database Connection successful";
}
else{
    echo "Database Connection failed";
}

?>
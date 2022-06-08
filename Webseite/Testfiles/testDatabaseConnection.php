<?php

require_once 'databaseConnection.php';

if(!$conn){
    echo "Verbindung zur Datenbank fehlgeschlagen";
}
else{
    echo "Verbindung zur Datenbank erfolgreich";
}

?>
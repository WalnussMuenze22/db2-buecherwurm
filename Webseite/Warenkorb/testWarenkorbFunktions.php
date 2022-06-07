<?php

require_once '../Database/databaseConnection.php';
require_once 'WarenkorbFunctions.php';

echo getOrCreateWarenkorb( getDatabaseConnection(), 12345 );

?>
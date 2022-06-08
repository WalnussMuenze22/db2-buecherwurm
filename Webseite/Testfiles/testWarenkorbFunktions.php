<?php

require_once '../Database/databaseConnection.php';
require_once '../Warenkorb/WarenkorbFunctions.php';

echo getOrCreateWarenkorb( getDatabaseConnection(), 12345 );

echo getWarenkorbItems( getDatabaseConnection(), 345 );
echo getWarenkorbTotal( getDatabaseConnection(), 345 );
echo addItemToWarenkorb( getDatabaseConnection(), 345, 123, 1 );
echo deleteItemFromWarenkorb( getDatabaseConnection(), 345 );
echo updateItemInWarenkorb( getDatabaseConnection(), 345, 2 );
?>
<?php

require_once $_SERVER["DOCUMENT_ROOT"] . "/db2-buecherwurm/Webseite/php/WarenkorbFunctions.php";

echo WarenkorbFunctions::getOrCreateWarenkorb();

?>
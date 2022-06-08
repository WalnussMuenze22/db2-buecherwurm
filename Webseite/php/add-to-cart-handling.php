<?php
    require_once("WarenkorbFunctions.php");
    $bestellungId = WarenkorbFunctions::getOrCreateWarenkorb();
    
    $artikelId = filter_input(INPUT_POST, "artikelId", FILTER_SANITIZE_NUMBER_INT);
    $menge = filter_input(INPUT_POST, "menge", FILTER_SANITIZE_NUMBER_INT);
    
    WarenkorbFunctions::addItemToWarenkorb($bestellungId, $artikelId, $menge);
    
    header("Location: /cart.php");
    exit();
?>

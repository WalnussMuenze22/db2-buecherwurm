<?php
    require_once($_SERVER["DOCUMENT_ROOT"] . "/php/WarenkorbFunctions.php");
    
    $bestellpositionId = filter_input(INPUT_POST, "bestellpositionId", FILTER_SANITIZE_NUMBER_INT);
    WarenKorbFunctions::deleteItemFromWarenkorb($bestellpositionId);
    
    header("Location: /cart.php");
    exit();
?>

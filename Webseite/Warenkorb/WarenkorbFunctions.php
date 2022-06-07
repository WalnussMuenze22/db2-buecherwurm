<?php

function getOrCreateWarenkorb($conn, $kundenID){
    $NumberOfOrders = getNumberOfOrdersInCreation($conn, $kundenID);
    if($NumberOfOrders == 0){
        createWarenkorb($conn, $kundenID);
        return getWarenkorb($conn, $kundenID);
    }
    elseif($NumberOfOrders == 1){
        return getWarenkorb($conn, $kundenID);
    }
    else{
        throw new Exception("FEHLER: Es gibt mehr als einen Warenkorb für diesen Kunden");
    }
}

// Gibt die Anzahl der noch nicht abgesendeten Bestellungen zurück
function getNumberOfOrdersInCreation($conn, $kundeID) {
    $sql = "SELECT COUNT(*) AS anzahl FROM bestellung WHERE kundenid = :kundeID AND status = 'wird erstellt'";
    $stmt = oci_parse($conn, $sql);
    oci_bind_by_name($stmt, ":kundeID", $kundeID);
    if(oci_execute($stmt)){
        $row = oci_fetch_assoc($stmt);
        return $row['ANZAHL'];
    }else{
        $error = ocierror($stmt);
        throw new Exception($error['message']);
    }
}

// Gibt den noch nicht abgesendeten Warenkorb des Kunden zurück
function getWarenkorb($conn, $userID) {
    $stmt = oci_parse($conn, "SELECT BestellungID FROM Bestellung WHERE KundenID = :userID AND Status = 'wird erstellt'"); 
    oci_bind_by_name($stmt, ':userID', $userID);
    oci_execute($stmt);
    $row = oci_fetch_array($stmt, OCI_ASSOC+OCI_RETURN_NULLS);
    $id= $row['ID'];
    return $id;
}

// Erstellt einen neuen Warenkorb für den Kunden
function createWarenkorb($conn, $userID) {
    $stmt = oci_parse($conn, "INSERT INTO Bestellung (Datum, Status, KundenID) VALUES (SYSDATE, 'wird erstellt', :userID)");
    oci_bind_by_name($stmt, ':userID', $userID);
    oci_execute($stmt);
}

?>
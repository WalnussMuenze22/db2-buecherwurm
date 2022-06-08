<?php

/**
 * It checks if there's a Warenkorb for the given KundenID, if there is none, it creates one, if there
 * is one, it returns it.
 * 
 * @param conn The connection to the database
 * @param kundenID The ID of the customer
 * 
 * @return The ID of the Warenkorb
 */
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


/**
 * It returns the number of orders in creation for a given customer.
 * 
 * @param conn The connection to the database
 * @param kundeID The ID of the customer
 * 
 * @return The number of orders in creation.
 */
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



/**
 * It returns the ID of the current order of the user.
 * 
 * @param conn The connection to the database
 * @param userID The ID of the user who is logged in
 * 
 * @return The ID of the current order.
 */
function getWarenkorb($conn, $userID) {
    $stmt = oci_parse($conn, "SELECT BestellungID FROM Bestellung WHERE KundenID = :userID AND Status = 'wird erstellt'"); 
    oci_bind_by_name($stmt, ':userID', $userID);
    oci_execute($stmt);
    $row = oci_fetch_array($stmt, OCI_ASSOC+OCI_RETURN_NULLS);
    $id= $row['ID'];
    return $id;
}



/**
 * It inserts a new row into the table Bestellung with the current date, the status "wird erstellt" and
 * the userID.
 * 
 * @param conn The connection to the database
 * @param userID The ID of the user who is currently logged in.
 */
function createWarenkorb($conn, $userID) {
    $stmt = oci_parse($conn, "INSERT INTO Bestellung (Datum, Status, KundenID) VALUES (SYSDATE, 'wird erstellt', :userID)");
    oci_bind_by_name($stmt, ':userID', $userID);
    oci_execute($stmt);
}


/**
 * It returns an array of all items in the shopping cart.
 * 
 * @param conn The connection to the database
 * @param BestellungID The ID of the order
 * 
 * @return Array of items in the shopping cart
 */
function getWarenkorbItems($conn, $BestellungID) {
    $stmt = oci_parse($conn, "SELECT BestellpositionID,
                                    Titel,
                                    Verlag,
                                    ArtikelID,
                                    Stueckpreis,
                                    Steuersatz,
                                    Menge,
                                    (Menge * Stueckpreis) AS Gesamtpreis
                            FROM Bestellposition
                            JOIN Artikel on Artikel.ArtikelID = Bestellposition.ArtikelID
                            WHERE BestellungID = :BestellungID");
    oci_bind_by_name($stmt, ':BestellungID', $BestellungID);
    oci_execute($stmt);
    $rows = array();
    while($row = oci_fetch_array($stmt, OCI_ASSOC+OCI_RETURN_NULLS)) {
        $rows[] = $row;
    }
    return $rows;
}


/**
 * It returns the total price of a shopping cart.
 * 
 * @param conn The connection to the database
 * @param BestellungID The ID of the order
 * 
 * @return The total price of the order.
 */
function getWarenkorbTotal($conn, $BestellungID) {
    $stmt = oci_parse($conn, "SELECT Gesamtpreis FROM Bestellung WHERE BestellungID = :BestellungID");
    oci_bind_by_name($stmt, ':BestellungID', $BestellungID);
    oci_execute($stmt);
    $row = oci_fetch_array($stmt, OCI_ASSOC+OCI_RETURN_NULLS);
    return $row['GESAMTPREIS'];
}


/**
 * It inserts a new row into the table Bestellposition.
 * 
 * @param conn The connection to the database
 * @param BestellungID The ID of the order
 * @param ArtikelID The ID of the article to be added to the order
 * @param Menge The amount of the item that the user wants to buy
 */
function addItemToWarenkorb($conn, $BestellungID, $ArtikelID, $Menge) {
    $stmt = oci_parse($conn, "INSERT INTO Bestellposition (BestellungID, ArtikelID, Menge) VALUES (:BestellungID, :ArtikelID, :Menge)");
    oci_bind_by_name($stmt, ':BestellungID', $BestellungID);
    oci_bind_by_name($stmt, ':ArtikelID', $ArtikelID);
    oci_bind_by_name($stmt, ':Menge', $Menge);
    oci_execute($stmt);
}



/**
 * It deletes a row from the table Bestellposition where the BestellpositionID is equal to the given
 * BestellpositionID.
 * 
 * @param conn The connection to the database
 * @param BestellpositionID The ID of the item in the shopping cart that should be deleted
 */
function deleteItemFromWarenkorb($conn, $BestellpositionID) {
    $stmt = oci_parse($conn, "DELETE FROM Bestellposition WHERE BestellpositionID = :BestellpositionID");
    oci_bind_by_name($stmt, ':BestellpositionID', $BestellpositionID);
    oci_execute($stmt);
}



/**
 * It updates the amount of a product in the shopping cart.
 * 
 * @param conn The connection to the database
 * @param BestellpositionID The ID of the item in the shopping cart
 * @param Menge The new amount of the item that the user wants to buy.
 */
function updateItemInWarenkorb($conn, $BestellpositionID, $Menge) {
    $stmt = oci_parse($conn, "UPDATE Bestellposition SET Menge = :Menge WHERE BestellpositionID = :BestellpositionID");
    oci_bind_by_name($stmt, ':BestellpositionID', $BestellpositionID);
    oci_bind_by_name($stmt, ':Menge', $Menge);
    oci_execute($stmt);
}

?>
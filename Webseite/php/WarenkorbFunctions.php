<?php

require_once $_SERVER["DOCUMENT_ROOT"] . "/php/databaseConnection.php";


class WarenkorbFunctions
{

    /**
     * It checks if there's a Warenkorb for the given KundenID, if there is none, it creates one, if there
     * is one, it returns it.
     * 
     * 
     * @return The ID of the Warenkorb
     */
    static function getOrCreateWarenkorb()
    {
        session_start();
        $kundenID = $_SESSION['userID'];
        $NumberOfOrders = WarenkorbFunctions::getNumberOfOrdersInCreation(DatabaseConnection::getDatabaseConnection(), $kundenID);
        if ($NumberOfOrders == 0) {
            WarenkorbFunctions::createWarenkorb(DatabaseConnection::getDatabaseConnection(), $kundenID);
            return WarenkorbFunctions::getWarenkorb(DatabaseConnection::getDatabaseConnection(), $kundenID);
        } elseif ($NumberOfOrders == 1) {
            return WarenkorbFunctions::getWarenkorb(DatabaseConnection::getDatabaseConnection(), $kundenID);
        } else {
            throw new Exception("FEHLER: Es gibt mehr als einen Warenkorb für diesen Kunden");
        }
    }


    /**
     * It returns the number of orders in creation for a given customer.
     * 
     * 
     * @return The number of orders in creation.
     */
    private static function getNumberOfOrdersInCreation()
    {
        session_start();
        $kundeID = $_SESSION['userID'];
        $sql = "SELECT COUNT(*) AS anzahl FROM bestellung WHERE kundenid = :kundeID AND status = 'editierbar'";
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), $sql);
        oci_bind_by_name($stmt, ":kundeID", $kundeID);
        if (oci_execute($stmt)) {
            $row = oci_fetch_assoc($stmt);
            return $row['ANZAHL'];
        } else {
            $error = ocierror($stmt);
            throw new Exception($error['message']);
        }
    }



    /**
     * It returns the ID of the current order of the user.
     * 
     * 
     * @return The ID of the current order.
     */
    private static function getWarenkorb()
    {
        session_start();
        $userID = $_SESSION['userID'];
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT BestellungID FROM Bestellung WHERE KundenID = :userID AND Status = 'editierbar'");
        oci_bind_by_name($stmt, ':userID', $userID);
        oci_execute($stmt, OCI_COMMIT_ON_SUCCESS);
        $row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS);
        $id = $row['BESTELLUNGID'];
        return $id;
    }



    /**
     * It inserts a new row into the table Bestellung with the current date, the status "editierbar" and
     * the userID.
     * 
     */
    private static function createWarenkorb()
    {
        session_start();
        $userID = $_SESSION['userID'];
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "INSERT INTO Bestellung (Datum, KundenID) VALUES (SYSDATE, :userID)");
        oci_bind_by_name($stmt, ':userID', $userID);
        oci_execute($stmt, OCI_COMMIT_ON_SUCCESS);
    }


    /**
     * It returns an array of all items in the shopping cart.
     * 
     * @param BestellungID The ID of the order
     * 
     * @return Array of items in the shopping cart
     */
    static function getWarenkorbItems($BestellungID)
    {
        session_start();
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT BestellpositionID,
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
        oci_execute($stmt, OCI_COMMIT_ON_SUCCESS);
        $rows = array();
        while ($row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS)) {
            $rows[] = $row;
        }
        return $rows;
    }


    /**
     * It returns the total price of a shopping cart.
     * 
     * @param BestellungID The ID of the order
     * 
     * @return The total price of the order.
     */
    static function getWarenkorbTotal($BestellungID)
    {
        session_start();
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT Gesamtpreis FROM Bestellung WHERE BestellungID = :BestellungID");
        oci_bind_by_name($stmt, ':BestellungID', $BestellungID);
        oci_execute($stmt, OCI_COMMIT_ON_SUCCESS);
        $row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS);
        return $row['GESAMTPREIS'];
    }


    /**
     * It inserts a new row into the table Bestellposition.
     * 
     * @param BestellungID The ID of the order
     * @param ArtikelID The ID of the article to be added to the order
     * @param Menge The amount of the item that the user wants to buy
     */
    static function addItemToWarenkorb($BestellungID, $ArtikelID, $Menge)
    {
        session_start();
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "INSERT INTO Bestellposition (BestellungID, ArtikelID, Menge) VALUES (:BestellungID, :ArtikelID, :Menge)");
        oci_bind_by_name($stmt, ':BestellungID', $BestellungID);
        oci_bind_by_name($stmt, ':ArtikelID', $ArtikelID);
        oci_bind_by_name($stmt, ':Menge', $Menge);
        oci_execute($stmt, OCI_COMMIT_ON_SUCCESS);
        oci_commit(DatabaseConnection::getDatabaseConnection());
    }



    /**
     * It deletes a row from the table Bestellposition where the BestellpositionID is equal to the given
     * BestellpositionID.
     * 
     * @param BestellpositionID The ID of the item in the shopping cart that should be deleted
     */
    static function deleteItemFromWarenkorb($BestellpositionID)
    {
        session_start();
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "DELETE FROM Bestellposition WHERE BestellpositionID = :BestellpositionID");
        oci_bind_by_name($stmt, ':BestellpositionID', $BestellpositionID);
        oci_execute($stmt, OCI_COMMIT_ON_SUCCESS);
    }



    /**
     * It updates the amount of a product in the shopping cart.
     * 
     * @param BestellpositionID The ID of the item in the shopping cart
     * @param Menge The new amount of the item that the user wants to buy.
     */
    static function updateItemInWarenkorb($BestellpositionID, $Menge)
    {
        session_start();
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "UPDATE Bestellposition SET Menge = :Menge WHERE BestellpositionID = :BestellpositionID");
        oci_bind_by_name($stmt, ':BestellpositionID', $BestellpositionID);
        oci_bind_by_name($stmt, ':Menge', $Menge);
        oci_execute($stmt, OCI_COMMIT_ON_SUCCESS);
    }



    /**
     * It updates the status of the order to "offen" and sets the RechnungsadresseID and
     * LieferadresseID to the given values.
     * 
     * @param BestellungID The ID of the order
     * @param RechnungsadresseID The ID of the billing address
     * @param LieferadresseID 1
     */
    static function sendOrder($BestellungID, $RechnungsadresseID, $LieferadresseID)
    {
        session_start();
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "UPDATE Bestellung SET Status = 'offen', RechnungsadresseID = :RechnungsadresseID, LieferadresseID = :LieferadresseID WHERE BestellungID = :BestellungID");
        oci_bind_by_name($stmt, ':BestellungID', $BestellungID);
        oci_bind_by_name($stmt, ':RechnungsadresseID', $RechnungsadresseID);
        oci_bind_by_name($stmt, ':LieferadresseID', $LieferadresseID);
        oci_execute($stmt, OCI_COMMIT_ON_SUCCESS);
    }
}

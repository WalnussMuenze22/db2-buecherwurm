<?php

require_once $_SERVER["DOCUMENT_ROOT"] . "/db2-buecherwurm/Webseite/php/databaseConnection.php";
class UserFunctions
{
    /**
     * It takes a connection, an email and a password and returns true if the user is logged in and false
     * if not.
     * 
     * @param email the email address of the user
     * @param password y$/X.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q.Q
     * 
     * @return true if the login was successful and false if it was not.
     */
    static function login($email, $password)
    {
        $passwordHash = md5($password);
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT KundenID 
                                FROM Kunde
                                JOIN Account on Kunde.AccountID = Account.AccountID
                                WHERE Email = :email AND PasswortHash = :password");
        oci_bind_by_name($stmt, ':email', $email);
        oci_bind_by_name($stmt, ':password', $passwordHash);
        oci_execute($stmt);
        $row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS);
        if ($row) {
            // Erstelle eine Session mit dem KundenID
            session_start();
            $userID = $row['KundenID'];
            $_SESSION['userID'] = $userID;
            //Setzte LastLogin auf aktuelle Zeit
            $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "UPDATE Account SET LastLogin = SYSDATE WHERE AccountID = (SELECT AccountID FROM Kunde WHERE KundenID = :userID)");
            oci_bind_by_name($stmt, ':userID', $userID);
            oci_execute($stmt);
            return true;
        } else {
            return false;
        }
    }


    /**
     * It destroys the session.
     * 
     */
    static function logout()
    {
        session_destroy();
    }


    /**
     * It takes a connection, an email and a password and inserts a new account, customer and saves the
     * customerID in the session.
     * 
     * @param email test@test.de
     * @param password the password the user entered
     */
    static function register($email, $password)
    {
        $passwordHash = md5($password);
        //Account anlegen
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "INSERT INTO Account (PasswortHash,  EMail, AccountTyp, LetzterLogin, Aktiv) VALUES (:passwordHash, :email, 'Kunde', SYSDATE, '1')");
        oci_bind_by_name($stmt, ':passwordHash', $passwordHash);
        oci_bind_by_name($stmt, ':email', $email);
        oci_execute($stmt);

        //AccountID ermitteln
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT AccountID FROM Account WHERE EMail = :email");
        oci_bind_by_name($stmt, ':email', $email);
        oci_execute($stmt);
        $row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS);
        $accountID = $row['AccountID'];

        //Kunde anlegen
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "INSERT INTO Kunde (AccountID) VALUES (:accountID)");
        oci_bind_by_name($stmt, ':accountID', $accountID);
        oci_execute($stmt);

        //KundenID ermitteln
        $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT KundenID FROM Kunde WHERE AccountID = :accountID");
        oci_bind_by_name($stmt, ':accountID', $accountID);
        oci_execute($stmt);
        $row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS);
        $kundenID = $row['KundenID'];

        //KundenID in Session speichern
        session_start();
        $_SESSION['userID'] = $kundenID;
    }
}
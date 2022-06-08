<?php
    require_once("../php/databaseConnection.php");
    
    $email = filter_input(INPUT_POST, "email", FILTER_SANITIZE_EMAIL);
    $password = filter_input(INPUT_POST, "password", FILTER_SANITIZE_SPECIAL_CHARS);
    


    $passwordHash = password_hash($password, PASSWORD_DEFAULT);
    
    //Account anlegen
    $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(),
        "INSERT INTO Account
        (PasswortHash,  EMail, AccountTyp, LetzterLogin, Aktiv)
        VALUES (:passwordHash, :email, 'Kunde', SYSDATE, '1')
        "
    );
    oci_bind_by_name($stmt, ':passwordHash', $passwordHash);
    oci_bind_by_name($stmt, ':email', $email);
    oci_execute($stmt);

    //AccountID ermitteln
    $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT AccountID FROM Account WHERE EMail = :email");
    oci_bind_by_name($stmt, ':email', $email);
    oci_execute($stmt);
    $row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS);
    $accountID = $row['ACCOUNTID'];

    //Kunde anlegen
    $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "INSERT INTO Kunde (AccountID) VALUES (:accountID)");
    oci_bind_by_name($stmt, ':accountID', $accountID);
    oci_execute($stmt);

    //KundenID ermitteln
    $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT KundenID FROM Kunde WHERE AccountID = :accountID");
    oci_bind_by_name($stmt, ':accountID', $accountID);
    oci_execute($stmt);
    $row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS);
    $kundenID = $row['KUNDENID'];

    //KundenID in Session speichern
    session_start();
    $_SESSION['userID'] = $kundenID;
    


    header("Location: /index.php");
    exit();
?>

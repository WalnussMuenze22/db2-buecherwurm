<?php
    require_once($_SERVER["DOCUMENT_ROOT"] . "/php/databaseConnection.php");
    
    $email = filter_input(INPUT_POST, "email", FILTER_SANITIZE_EMAIL);
    $password = filter_input(INPUT_POST, "password", FILTER_SANITIZE_SPECIAL_CHARS);

    $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(),
        "SELECT KundenID, passwortHash
        FROM Kunde
        JOIN Account on Kunde.AccountID = Account.AccountID
        WHERE Email = :email
        "
    );
    
    oci_bind_by_name($stmt, ':email', $email);
    oci_execute($stmt);

    

    if ($row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS)) {
        // Email gefunden

        
        if (password_verify($password, $row["PASSWORTHASH"])) {
            // Passwort richtig
            
            // Erstelle eine Session mit dem KundenID
            session_start();
            $userID = $row['KUNDENID'];
            $_SESSION['userID'] = $userID;
            
            //Setzte LastLogin auf aktuelle Zeit
            $stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "UPDATE Account SET LetzterLogin = SYSDATE WHERE AccountID = (SELECT AccountID FROM Kunde WHERE KundenID = :userID)");
            oci_bind_by_name($stmt, ':userID', $userID);
            oci_execute($stmt);
            
            header("Location: /index.php");
            exit();
        } else {
            header("Location: /login.php?login=failed");
            exit();
        }
    } else {
        header("Location: /login.php?login=failed");
        exit();
    }
?>

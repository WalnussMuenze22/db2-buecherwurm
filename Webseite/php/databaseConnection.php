<?php
class DatabaseConnection {
    private static $conn;

private static function openDatabaseConnection(){
    $db_username = "inf2305";
    $db_password = "P0ahW8Jq+P6EwXrv8stQkYFUfNDl+v";
    $tns = "
    (DESCRIPTION =
        (ADDRESS_LIST =
          (ADDRESS = (PROTOCOL = TCP)(HOST = studidb.gm.th-koeln.de)(PORT = 1521))
        )
        (CONNECT_DATA =
          (SID = vlesung)
        )
      )
      ";
    
    $conn = oci_pconnect($db_username, $db_password, $tns);
    if (!$conn) {
        $e = oci_error();
        trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }
    return $conn;
}


static function getDatabaseConnection(){
    if(self::$conn == null){
        self::$conn = self::openDatabaseConnection();
    }
}

}
?>
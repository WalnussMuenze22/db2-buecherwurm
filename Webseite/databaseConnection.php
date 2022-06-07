<?php

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

  $conn = oci_connect($db_username, $db_password, $tns);
  if (!$conn) {
      $e = oci_error();
      trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
  }
  else {
    echo "Oracle Connection Successful";
 }
<?php

require_once $_SERVER["DOCUMENT_ROOT"] . "/db2-buecherwurm/Webseite/php/UserFunctions.php";


// Teste für den UserFunctions::register()
echo "Teste für UserFunctions::register()<br>";
$email = "test@test.de";
$password = "test";
UserFunctions::register($email, $password);






//Test für UserFunctions::login
echo "Test für UserFunctions::login<br>";

if(UserFunctions::login("test@example.com" , "test")){
    echo "Login erfolgreich<br>";
}
else{
    echo "Login fehlgeschlagen<br>";
}
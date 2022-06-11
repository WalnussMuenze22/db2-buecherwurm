<!doctype html>
<html lang="de">
    <?php include 'head.php' ?>
	<body >
        <?php include 'header.php' ?>
		<div class="container Freed" id="login">
		<?php
		$error = filter_input(INPUT_GET, "  ", FILTER_SANITIZE_SPECIAL_CHARS);
		?>
            <h1>Fehler</h1>
            <div class="alert alert-danger" role="alert">
                <?php 
                echo 'Es ist eine Fehler aufgetreten: '. $error; 
                ?>
		</div>
        <?php include 'footer.php' ?>
	</body>
</html>

<?php

//    exit();
// 				if(oci_execute($stmt) == false) {header('Location: /error.php?message=1234');}

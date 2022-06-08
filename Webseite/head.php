<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bücherwurm</title>
    <link rel="icon" href="images/buecherwurm.png" type="image/icon type">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles/main.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <?php
	session_start();
	if ($_SESSION["userID"] != NULL) {
		echo '<script>var loggedIn = true;</script>';
	} else {
		echo '<script>var loggedIn = false;</script>';
	}
	?>
</head>
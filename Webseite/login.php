<!doctype html>
<html lang="de">
    <?php include 'head.php' ?>
	<body >
        <?php include 'header.php' ?>
		<div class="container Freed" id="login">
		<?php
		if(filter_input(INPUT_GET, "login", FILTER_SANITIZE_SPECIAL_CHARS) == 'failed'){
			echo '<div class="alert alert-danger" role="alert">
					E-Mail oder Passwort ist falsch!
		  		</div>';
		}
		?>
				<form action="/php/login-handling.php" method="post" autocomplete="on">
					<div class="form-floating mb-3">						
						<input type="email" class="form-control" id="login_email" placeholder="example@domain.sub" name="email" required="">
						<label for="login_email" class="form-label">E-Mail-Addresse</label>
						<div id="emailHelp" class="form-text">Diese Daten werden niemals geteilt!</div>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control" id="login_password" placeholder="Password" name="password" required="">
						<label for="login_password" class="form-label">Passwort</label>
					</div>
					<div class="row">
						<div class="col"><button type="submit" class="btn btn-success">Login</button></div>
					</div>
				  </form>	  
		</div>
        <?php include 'footer.php' ?>
	</body>
</html>

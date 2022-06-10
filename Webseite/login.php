<!doctype html>
<html lang="de">
    <?php include 'head.php' ?>
	<body >
        <?php include 'header.php' ?>
        <!--Login
			div mit class container mit id login
				form
					div mit class form-floating mb-3
						input email mit class form-control mit id login_email
						label mit for login_email mit class form-label
						div mit id emailHelp mit class form-text
					div mit class form-floating mb-3
						input password mit class form-control mit id login_password
						label mit for login_password mit class form-label
					div mit class mb-3 form-check
						input checkbox mit class form-check-input mit id login_check
						label mit for login_check mit class form-check-label
					div mit class row
						div mit class col
							button mit class btn btn-link onclick returnToMain();
						div mit class col
							button submit mit class btn btn-success
		-->
		<div class="container Freed" id="login">
				<form action="/php/login-handling.php" method="post" autocomplete="on">
					<div class="form-floating mb-3">						
						<input type="email" class="form-control" id="login_email" placeholder="example@domain.sub" name="email">
						<label for="login_email" class="form-label">E-Mail-Addresse</label>
						<div id="emailHelp" class="form-text">Diese Daten werden niemals geteilt!</div>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control" id="login_password" placeholder="Password" name="password">
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

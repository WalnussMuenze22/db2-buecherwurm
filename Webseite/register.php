<!doctype html>
<html lang="de">
    <?php include 'head.php' ?>
	<body >
        <?php include 'header.php' ?>
		<div class="container Freed" id="register">
			<form class="row g-3" action="php/register-handling.php" method="post" autocomplete="on">
				<div class="col-md-6">
					<label for="reg_email" class="form-label">E-Mail</label>
					<input type="email" class="form-control" id="reg_email" name="email" required="">
				</div>
				<div class="col-md-6">
					<label for="reg_password" class="form-label">Passwort</label>
					<input type="password" class="form-control" id="reg_password" name="password" required="">
				</div>
				<div class="col-12">
					<div class="row">
						<div class="col"><button type="submit" class="btn btn-success">Registrieren</button></div>
					</div>
				</div>
			  </form>
		</div>
        <?php include 'footer.php' ?>
	</body>
</html>
<!doctype html>
<html lang="de">
    <?php include 'head.php' ?>
	<body >
        <?php include 'header.php' ?>
		<!--Login
			div mit class container mit id register
				form mit class row g-3
					div mit class col-md6
						label mit for reg_email mit class form-label
						input email mit class form-control mit id reg_email
					div mit class col-md-6
						label mit for reg_password mit class form-label
						input password mit class form-control mit id reg_password
					div mit class col-12
						label mit for reg_adress mit class form-label
						input text mit class form-control mit id reg_adress
					div mit class col-12
						label mit for reg_adress_1 mit class form-label
						input text mit class form-control mit id reg_adress_1
					div mit class col-md-10
						label mit for reg_stadt mit class form-label
						input text mit class form-control mit id reg_stadt
					div mit class col-md-2
						label mit for reg_plz mit class form-label
						input text mit class form-controll mit id reg_plz
					div mit class col-12
						div mit class form-check
							input checkbox mit class form-check-input mit id reg_check
							label mit class form-check-label mit for reg_check
					div mit class col-12
						div mit class row
							div mit class col
								button mit class btn btn-link mit onclick returnToMain()
							div mit class col
								button submit mit class btn btn-success
		-->
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
				<!--
				<div class="col-12">
					<label for="reg_adress" class="form-label">Adresse</label>
					<input type="text" class="form-control" id="reg_adress" placeholder="Straße. Nummer">
				</div>
				<div class="col-12">
					<label for="reg_adress_1" class="form-label">Adresse 2</label>
					<input type="text" class="form-control" id="reg_adress_1" placeholder="Wohnung, Etage, Studio ...">
				</div>
				<div class="col-md-10">
					<label for="reg_stadt" class="form-label">Stadt</label>
					<input type="text" class="form-control" id="reg_stadt">
				</div>
				<div class="col-md-2">
				  <label for="reg_plz" class="form-label">PLZ</label>
				  <input type="text" class="form-control" id="reg_plz">
				</div>
				<div class="col-12">
				  <div class="form-check">
					<input class="form-check-input" type="checkbox" id="reg_check">
					<label class="form-check-label" for="reg_check">
					  Angemeldet bleiben
					</label>
				  </div>
				</div>
-->
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
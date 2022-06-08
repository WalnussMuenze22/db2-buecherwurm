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
		<div class="container" id="login">
				<form action="/php/login-handling.php" method="post" autocomplete="on">
					<div class="form-floating mb-3">						
						<input type="email" class="form-control" id="login_email" placeholder="example@domain.sub">
						<label for="login_email" class="form-label">Email Addresse</label>
						<div id="emailHelp" class="form-text">Diese Daten werden niemals geteilt!</div>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control" id="login_password" placeholder="Password">
						<label for="login_password" class="form-label">Passwort</label>
					</div>
					<div class="mb-3 form-check">
						<input type="checkbox" class="form-check-input" id="login_check">
						<label for="login_check" class="form-check-label" >Angemeldet bleiben</label>
					</div>
					<div class="row">
						<div class="col"><button type="button" class="btn btn-link" onclick="returnToMain();">Zurück</button></div>
						<div class="col"><button type="submit" class="btn btn-success">Login</button></div>
					</div>
				  </form>	  
		</div>
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
		<div class="container" id="register">
			<form class="row g-3" action="/php/register-handling.php" method="post" autocomplete="on">
				<div class="col-md-6">
					<label for="reg_email" class="form-label">E-Mail</label>
					<input type="email" class="form-control" id="reg_email">
				</div>
				<div class="col-md-6">
					<label for="reg_password" class="form-label">Passwort</label>
					<input type="password" class="form-control" id="reg_password">
				</div>
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
				<div class="col-12">
					<div class="row">
						<div class="col"><button type="button" class="btn btn-link" onclick="returnToMain();">Zurrück</button></div>
						<div class="col"><button type="submit" class="btn btn-success">Registrieren</button></div>
					</div>
				</div>
			  </form>
		</div>
		<!--Account
			div mit class container mit id account
				div mit class row
					div mit class col-3
						div mit class list-group mit id list-tab mit role tablist
							a mit class list-group-item list-group-item-action list-group-item-success active mit id allgemein-list mit data-bs-toggle list mit role tab mit aria-controls allgemein
							a mit class list-group-item list-group-item-action list-group-item-success mit id passwort-list mit data-bs-toggle list mit role tab mit aria-controls passwort
							a mit class list-group-item list-group-item-action list-group-item-success mit id adress-list mit data-bs-toggle list mit role tab mit aria-controls adresse
							a mit class list-group-item list-group-item-action list-group-item-success mit id loeschen-list mit data-bs-toggle list mit role tab mit aria-controls loeschen
					div mit class col-9
						div mit class  tab-content mit id nav-tabContent
							div mit class tab-pane fade show active mit id allgemein mit role tabpanel mit aria-labelledby allgemein-list
							div mit class tab-pane fade mit id passwort mit role tabpanel mit aria-labelledby passwort-list
							div mit class tab-pane fade mit id adresse mit role tabpanel mit aria-labelledby adresse-list
							div mit class tab-pane fade mit id loeschen mit role tabpanel mit aria-labelledby loeschen-list
		-->
		<div class="container" id="account">
			<div class="row">
				<div class="col-3">
				  <div class="list-group" id="list-tab" role="tablist">
					<a class="list-group-item list-group-item-action active list-group-item-success" id="allgemein-list" data-bs-toggle="list" href="#allgemein" role="tab" aria-controls="allgemein" >Allgemein</a>
					<a class="list-group-item list-group-item-action list-group-item-success" id="passwort-list" data-bs-toggle="list" href="#passwort" role="tab" aria-controls="passwort" >Passwort</a>
					<a class="list-group-item list-group-item-action list-group-item-success" id="adresse-list" data-bs-toggle="list" href="#adresse" role="tab" aria-controls="adresse" >Adresse</a>
					<a class="list-group-item list-group-item-action list-group-item-success" id="loeschen-list" data-bs-toggle="list" href="#loeschen" role="tab" aria-controls="loeschen" >Settings</a>
				  </div>
				</div>
				<div class="col-9">
				  <div class="tab-content" id="nav-tabContent">
					<div class="tab-pane fade show active" id="allgemein" role="tabpanel" aria-labelledby="allgemein-list">allg</div>
					<div class="tab-pane fade" id="passwort" role="tabpanel" aria-labelledby="passwort-list">pass</div>
					<div class="tab-pane fade" id="adresse" role="tabpanel" aria-labelledby="adresse-list">address</div>
					<div class="tab-pane fade" id="loeschen" role="tabpanel" aria-labelledby="loeschen-list">loesch</div>
				  </div>
				</div>
			  </div>
		</div>

        <?php
        //Damit das JS von Dennis noch funktioniert
        $tab = $_GET['tab'];
        if($tab == "Login"){
            echo "<script>openLogin();</script>";
        }elseif($tab == "Register"){
            echo "<script>openRegister();</script>";
        }elseif($tab == "Account"){
            echo "<script>openAccount();</script>";
        }
        ?>
        
        <?php include 'footer.php' ?>
	</body>
</html>

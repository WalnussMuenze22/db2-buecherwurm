<!doctype html>
<html lang="de">
    <?php include 'head.php' ?>
	<body >
        <?php include 'header.php' ?>
        <!--Shopping Cart
			div mit id cart
				div mit class table-responsive
					table mit class table table
						thead mit scopes col
						tbody mit scope row am Anfang der Zeile
						tfoot mit Gesamtpreis und Checkout Button
			Ids
				art_nr  art_title  art_author menge.placeholder gesamtpreis entfernen
		-->
		<div class="container" id="cart">
            <div class="table-responsive">
                <table class="table table">
                <thead>
                	<tr>
                		<th scope="col">Art.-Nummer</th>
                    	<th scope="col">Buchtitel</th>
                    	<th scope="col">Autor</th>
                    	<th scope="col">Menge</th>
                    	<th scope="col">Preis</th>
                	</tr>
                </thead>
                <tbody>
                	<tr>
                    	<th scope="row" id="art_nr">1</th>
                    	<td id="art_title">Titel 1</td>
                    	<td id="art_author">Max Mustermann</td>
                    	<td>
                        	<form>
                            	<input type="text" class="form-control mengeAktiv" placeholder="5" id="menge">                         
                        	</form>
                    	</td>
                    	<td id="gesamtpreis">50 €</td>
                    	<td>
                        	<form>
                            	<button type="button" class="btn btn-danger checkoutWidth" id="entfernen">Entfernen</button>
                        	</form>
                    	</td>
                  	</tr>
                	<tr>
                    	<th scope="row">2</th>
                    	<td>Titel 2</td>
                    	<td>Martina Musterfrau</td>
                    	<td>
                        	<form>
                            	<input type="text" class="form-control mengeAktiv" placeholder="2" id="menge">                         
                        	</form>
                    	</td>
                    	<td>30 €</td>
                    	<td>
                        	<form>
                            	<button type="button" class="btn btn-danger checkoutWidth">Entfernen</button>
                        	</form>
                    	</td>
                	</tr>
                	<tr>
                    	<th scope="row">3</th>
                    	<td>Ttel 3</td>
                    	<td>Würfelmann</td>
                    	<td>
                        	<form>
                            	<input type="text" class="form-control mengeAktiv" placeholder="1" id="menge">                         
                        	</form>
                    	</td>
                    	<td>20 €</td>
                    	<td>
                        	<form>
                            	<button type="button" class="btn btn-danger checkoutWidth">Entfernen</button>
                        	</form>
                    	</td>
                	</tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" class="gesPreis">Gesamtpreis:</td>
                        <td>70 €</td>
                        <td>
                            <form>
                                <button type="button" class="btn btn-success checkoutWidth"><img src="images/checkout.png" alt="Checkout"></button>
                            </form>
                        </td>
                    </tr>   
                </tfoot>
              </table>
            </div>
            
		</div>
		<div class="container" id="login">
			<form>
				<div class="form-floating mb-3">						
					<input type="email" class="form-control" id="exampleInputEmail1" placeholder="example@domain.sub">
					<label for="exampleInputEmail1" class="form-label">Email Addresse</label>
					<div id="emailHelp" class="form-text">Diese Daten werden niemals geteilt!</div>
				</div>
				<div class="form-floating mb-3">
					<input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
					<label for="exampleInputPassword1" class="form-label">Passwort</label>
				</div>
				<div class="mb-3 form-check">
					<input type="checkbox" class="form-check-input" id="exampleCheck1">
					<label class="form-check-label" for="exampleCheck1">Angemeldet bleiben</label>
				</div>
				<div class="row">
					<div class="col"><button type="button" class="btn btn-link" onclick="returnToMain();">Zurrück</button></div>
					<div class="col"><button type="submit" class="btn btn-success">Login</button></div>
				</div>
			  </form>	  
	</div>
	<div class="container" id="register">
		<form class="row g-3">
			<div class="col-md-6">
				<label for="inputEmail4" class="form-label">E-Mail</label>
				<input type="email" class="form-control" id="inputEmail4">
			</div>
			<div class="col-md-6">
				<label for="inputPassword4" class="form-label">Passwort</label>
				<input type="password" class="form-control" id="inputPassword4">
			</div>
			<div class="col-12">
				<label for="inputAddress" class="form-label">Adresse</label>
				<input type="text" class="form-control" id="inputAddress" placeholder="Straße. Nummer">
			</div>
			<div class="col-12">
				<label for="inputAddress2" class="form-label">Adresse 2</label>
				<input type="text" class="form-control" id="inputAddress2" placeholder="Wohnung, Etage, Studio ...">
			</div>
			<div class="col-md-10">
				<label for="inputCity" class="form-label">Stadt</label>
				<input type="text" class="form-control" id="inputCity">
			</div>
			<div class="col-md-2">
				<label for="inputZip" class="form-label">PLZ</label>
				<input type="text" class="form-control" id="inputZip">
			</div>
			<div class="col-12">
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="gridCheck">
					<label class="form-check-label" for="gridCheck">
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
		<footer class="bg-dark text-center text-white fixed-bottom">
			<div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
				© 2022 Copyright:
				<a class="text-white" href="https://dennis-kliewer.de/dbs2praktikum">buecherwurm.de</a>
			</div>
		</footer>
	</body>
</html>
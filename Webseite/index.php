<!doctype html>
<html lang="de">
    <?php include 'head.php' ?>
	<body >
        <?php include 'header.php' ?>
		<div class="container" id="storeItems">
			<div class="row row-cols-auto">

			<?php
				require_once $_SERVER["DOCUMENT_ROOT"] . "/php/databaseConnection.php";

				$stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT Titel, Beschreibung, AutorenListe, Verlag, Preis FROM Buchinformationen ORDER BY Titel ASC");
				oci_execute($stmt);
				while($row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS)){
					$autorenListe = explode('#', $row["AUTORENLISTE"]);
					
					echo '<div class="col mt-2">
					<div class="card" style="width: 18rem;">
						<img src="images/logo.jpg" class="card-img-top" alt="..." id="art_image">
						<div class="card-body">
							<h5 class="card-title" id="art_title">'.$row['TITEL'].'</h5>
							<p class="card-text" id="art_besch">'.$row['BESCHREIBUNG'].'</p>
						</div>
						<ul class="list-group list-group-flush">
							<li class="list-group-item" id="autor">Autor: '.implode(', ', $autorenListe).'</li>
							<li class="list-group-item " id="verlag">Verlag: '.$row['VERLAG'].'</li>
							<li class="list-group-item" id="preis">Preis: '.$row['PREIS'].'€</li>
						</ul>
						<div class="card-body">
							<form>
								<div class="row justify-content-md-center">
									<div class="col pt-1">
										<input type="text" class="form-control pt-1" placeholder="Menge..." id="menge">
									</div>
									<div class="col">
										<button type="button" class="btn btn-success btn-sm shoppingCart">
											<span class="material-icons pt-1">
											shopping_cart
											</span>
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>';
				}

			?>
			</div>
		</div>
        <?php include 'footer.php' ?>
	</body>
</html>
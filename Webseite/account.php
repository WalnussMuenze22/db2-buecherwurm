<!doctype html>
<html lang="de">
<?php include 'head.php' ?>

<body>
	<?php include 'header.php' ?>
	<div class="container Freed" id="account">
		<div class="row">
			<div class="col-3">
				<div class="list-group" id="list-tab" role="tablist">
					<a class="list-group-item list-group-item-action active list-group-item-success" id="allgemein-list" data-bs-toggle="list" href="#allgemein" role="tab" aria-controls="allgemein">Allgemein</a>
					<a class="list-group-item list-group-item-action list-group-item-success" id="passwort-list" data-bs-toggle="list" href="#passwort" role="tab" aria-controls="passwort">Passwort</a>
					<a class="list-group-item list-group-item-action list-group-item-success" id="adresse-list" data-bs-toggle="list" href="#adresse" role="tab" aria-controls="adresse">Adresse</a>
					<a class="list-group-item list-group-item-action list-group-item-success" id="loeschen-list" data-bs-toggle="list" href="#loeschen" role="tab" aria-controls="loeschen">Settings</a>
				</div>
			</div>
			<div class="col-9">
				<div class="tab-content" id="nav-tabContent">
					<div class="tab-pane fade show active" id="allgemein" role="tabpanel" aria-labelledby="allgemein-list">
						<h1>Bestellübersicht</h1>
						<p>Hier finden Sie eine Übersicht über Ihre Bestellungen:</p>
			
						<?php
						require_once $_SERVER["DOCUMENT_ROOT"] . "/php/databaseConnection.php";
						session_start();

						$stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT Bestellung.BestellungID , Status, SUM ((Menge*Stueckpreis)) AS Gesamtpreis
																						FROM Bestellung
																						JOIN Bestellposition on Bestellung.BestellungID = Bestellposition.BestellungID
																						GROUP BY Bestellung.BestellungID, Status, KundenID
																						HAVING KundenID = :kundeID");
						oci_bind_by_name($stmt, ":kundeID", $_SESSION['userID']);
						oci_execute($stmt);
						while ($row = oci_fetch_array($stmt, OCI_ASSOC)) {
							echo '
							<ul class="list-group">
								<li class="list-group-item"><b>Bestellung:</b> '.$row["BESTELLUNGID"].' <b>Gesamtpreis: </b>' .$row["GESAMTPREIS"].'€<b>      Status:</b> '.$row["STATUS"].'</li></li>
									<ul class="ligroupst-">';
									$stmt2 = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT Titel, Menge, Stueckpreis, (Menge*Stueckpreis) AS Gesamtpreis
																										FROM Bestellposition
																										JOIN Buchinformationen ON Buchinformationen.ArtikelID = Bestellposition.ArtikelID 
																										WHERE BestellungID = :bestellungID");
									oci_bind_by_name($stmt2, ":bestellungID", $row["BESTELLUNGID"]);
									oci_execute($stmt2);
									while ($row2 = oci_fetch_array($stmt2, OCI_ASSOC)) {
										echo '
										<li class="list-group-item"><b>Buch:</b> '.$row2["TITEL"].' <b>Anzahl: </b>' .$row2["MENGE"].'<b> Stückpreis: </b>' .$row2["STUECKPREIS"].'€<b> Gesamtpreis: </b>' .$row2["GESAMTPREIS"].'€</li>

										';
									}
								echo '
									</ul>
								</li>
							</ul>';
						}

						?>
					</div>
				</div>
				<div class="tab-pane fade" id="passwort" role="tabpanel" aria-labelledby="passwort-list">pass</div>
				<div class="tab-pane fade" id="adresse" role="tabpanel" aria-labelledby="adresse-list">address</div>
				<div class="tab-pane fade" id="loeschen" role="tabpanel" aria-labelledby="loeschen-list">loesch</div>
			</div>
		</div>
	</div>
	</div>
	<?php include 'footer.php' ?>
</body>

</html>
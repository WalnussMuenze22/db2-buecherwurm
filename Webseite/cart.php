<!doctype html>
<html lang="de">
<?php include 'head.php' ?>

<body>
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
                    	<th scope="row" id="art_nr">-3,5</th>
                    	<td id="art_title">Waschmaschine</td>
                    	<td id="art_author"></td>
                    	<td>
                        	<form>
                            	<input type="text" class="form-control mengeAktiv" value="42" id="menge" disabled="">               
                        	</form>
                    	</td>
                    	<td id="gesamtpreis">21000 €</td>
                    	<td>
                        	<form action="/php/remove-bestellposition-handling.php" method="post">
								<input type="number" name="bestellpositionId" value="' . $row['BESTELLPOSITIONID'] . '" style="display: none;">
                            	<button type="submit" class="btn btn-danger checkoutWidth" id="entfernen">Entfernen</button>
                        	</form>
                    	</td>
                  	</tr>


					<?php

					require_once $_SERVER["DOCUMENT_ROOT"] . "/php/databaseConnection.php";

					$stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT BestellpositionId, Bestellposition.ArtikelID, Titel, Autorenliste, Menge, Bestellposition.Stueckpreis, Menge*Bestellposition.Stueckpreis AS Gesamtpreis
																					FROM Bestellung
																					JOIN Bestellposition on Bestellung.BestellungID = Bestellposition.BestellungID
																					JOIN Buchinformationen on Bestellposition.ArtikelID = Buchinformationen.ArtikelID
																					WHERE KundenID = :kundenID
																					AND status = 'editierbar'");
					oci_bind_by_name($stmt, ':kundenID', $_SESSION['userID']);
					oci_execute($stmt);
					while ($row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS)) {
						$autorenListe = explode('#', $row["AUTORENLISTE"]);
						echo '


						
                	<tr>
                    	<th scope="row" id="art_nr">' . $row['ARTIKELID'] . '</th>
                    	<td id="art_title">' . $row['TITEL'] . '</td>
                    	<td id="art_author">' . implode(', ', $autorenListe) . '</td>
                    	<td>
                        	<form>
                            	<input type="text" class="form-control mengeAktiv" value="' . $row['MENGE'] . '" id="menge" disabled="">               
                        	</form>
                    	</td>
                    	<td id="gesamtpreis">32,97 €</td>
                    	<td>
                        	<form action="/php/remove-bestellposition-handling.php" method="post">
								<input type="number" name="bestellpositionId" value="' . $row['BESTELLPOSITIONID'] . '" style="display: none;">
                            	<button type="submit" class="btn btn-danger checkoutWidth" id="entfernen">Entfernen</button>
                        	</form>
                    	</td>
                  	</tr>

						';
					}
					?>

				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" class="gesPreis">Gesamtpreis:</td>
						<td><?php

							$stmt = oci_parse(DatabaseConnection::getDatabaseConnection(), "SELECT SUM(Menge*Bestellposition.Stueckpreis) as SUMME
							FROM Bestellung
							JOIN Bestellposition ON Bestellung.BestellungId = Bestellposition.BestellungId
							WHERE KundenId = :kundenID
							AND status = 'editierbar'");
							oci_bind_by_name($stmt, ':kundenID', $_SESSION['userID']);
							oci_execute($stmt);
							$row = oci_fetch_array($stmt, OCI_ASSOC + OCI_RETURN_NULLS);
							echo ' 21032,97  €';
							?>
						</td>
						<td>
							<form action="/php/send-order-handling.php" method="post">
								<button type="submit" class="btn btn-success checkoutWidth"><img src="images/checkout.png" alt="Checkout"></button>
							</form>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>

	</div>

	<?php include 'footer.php' ?>
</body>

</html>
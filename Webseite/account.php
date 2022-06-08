<!doctype html>
<html lang="de">
    <?php include 'head.php' ?>
	<body >
        <?php include 'header.php' ?>
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
		<div class="container Freed" id="account">
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
        <?php include 'footer.php' ?>
	</body>
</html>

<!doctype html>
<html lang="de">
    <head>
        <?php include 'head.php' ?>
        <script src="menge.js"></script>
    </head>
	<body >
        <?php include 'header.php' ?>
		<div class="container">
			<div class="card" style="width: 18rem;">
				<img src="logo.jpg" class="card-img-top" alt="...">
				<div class="card-body">
					<h5 class="card-title">Titel</h5>
					<p class="card-text">Buchbeschreibung...</p>
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">Autor: Max Mustermann</li>
					<li class="list-group-item">Verlag: Muster Verlag GmbH</li>
					<li class="list-group-item">Preis: 15,00€</li>
				</ul>
				<div class="card-body">
					<form>
						<div class="row justify-content-md-center">
							<div class="col pt-1">
                                <label>
                                    <input type="text" class="form-control menge pt-1" placeholder="Menge..." onmouseenter="mengeEnd();" onmouseleave="mengeClick();">
                                </label>
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
		</div>
        <?php include 'footer.php' ?>
	</body>
</html>
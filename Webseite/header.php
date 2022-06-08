<header>
			<nav class="navbar fixed-top navbar-expand-lg bg-dark navbar-dark justify-content-between">
				<!-- Brand -->
				<div class="container-fluid">
					<a class="navbar-brand" href="index.php">
						<img class="responsiveImg img-thumbnail" src="buecherwurm.png" alt="Logo"/>
					</a>
					<!-- Links -->
					<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav me-auto mb-2 mb-lg-0">
							<li class="nav-item active">
								<a class="nav-link active" href="index.php" id="start-link">Start</a>
							</li>
							<li class="nav-item">
								<a href="about.php" class="nav-link" id="about-link">Über uns</a>
							</li>
						</ul>
						<form class="d-flex">
								<input class="form-control me-2" type="search" placeholder="Suchbegriff..." aria-label="Search">
								<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Suchen</button>
						</form>
						<ul class="navbar-nav">
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
								Anmelden
								</a>
								<ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink">
									<li id="dropdown-login"><a class="dropdown-item" onclick="openLogin();">Anmelden</a></li>
									<li id="dropdown-register"><a class="dropdown-item" onclick="openRegister();">Registrieren</a></li>
									<li id="dropdown-account"><a class="dropdown-item" onclick="openAccount();">Account</a></li>
								</ul>
							</li>
							<li class="nav-item ">
								<a class="nav-link" href="cart.php">
									<span class="material-icons">
									shopping_cart
									</span>
								</a>
							</li>
						</ul>						
					</div>
				</div>
	  		</nav>
		</header>
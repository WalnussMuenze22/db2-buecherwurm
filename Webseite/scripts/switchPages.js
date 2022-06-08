function openLogin(){
    document.getElementById("login").classList.add("Freed");
    document.getElementById("register").classList.remove("Freed");
    document.getElementById("account").classList.remove("Freed");
}

function openRegister(){
    document.getElementById("login").classList.remove("Freed");
    document.getElementById("register").classList.add("Freed");
    document.getElementById("account").classList.remove("Freed");
}

function openAccount(){
    document.getElementById("login").classList.remove("Freed");
    document.getElementById("register").classList.remove("Freed");
    document.getElementById("account").classList.add("Freed");
}
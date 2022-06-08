function openLogin(){
    var temp2 = document.getElementById("login");
    temp2.classList.add("Freed");
    var temp3 = document.getElementById("register");
    temp3.classList.remove("Freed");
    var temp4 = document.getElementById("account");
    temp4.classList.remove("Freed");
}

function openRegister(){
    var temp2 = document.getElementById("register");
    temp2.classList.add("Freed");
    var temp3 = document.getElementById("login");
    temp3.classList.remove("Freed");
    var temp4 = document.getElementById("account");
    temp4.classList.remove("Freed");
}

function openAccount(){
    var temp2 = document.getElementById("login");
    temp2.classList.remove("Freed");
    var temp3 = document.getElementById("register");
    temp3.classList.remove("Freed");
    var temp4 = document.getElementById("account");
    temp4.classList.add("Freed");
}
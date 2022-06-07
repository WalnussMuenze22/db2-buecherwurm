var itemBefore;

function openLogin(){
    var temp1 = document.getElementById("storeItems");
    temp1.classList.add("storeBlocked");
    var temp2 = document.getElementById("login");
    temp2.classList.add("Freed");
    var temp3 = document.getElementById("register");
    temp3.classList.remove("Freed");
    var temp4 = document.getElementById("account");
    temp4.classList.remove("Freed");
    
}

function openRegister(){
    var temp1 = document.getElementById("storeItems");
    temp1.classList.add("storeBlocked");
    var temp2 = document.getElementById("register");
    temp2.classList.add("Freed");
    var temp3 = document.getElementById("login");
    temp3.classList.remove("Freed");
    var temp4 = document.getElementById("account");
    temp4.classList.remove("Freed");
    
}

function openAccount(){
    var temp1 = document.getElementById("storeItems");
    temp1.classList.add("storeBlocked");
    var temp2 = document.getElementById("login");
    temp2.classList.remove("Freed");
    var temp3 = document.getElementById("register");
    temp3.classList.remove("Freed");
    var temp4 = document.getElementById("account");
    temp4.classList.add("Freed");
}

function returnToMain(){
    var temp1 = document.getElementById("storeItems");
    temp1.classList.remove("storeBlocked");
    var temp2 = document.getElementById("login");
    temp2.classList.remove("Freed");
    var temp3 = document.getElementById("register");
    temp3.classList.remove("Freed");
    var temp4 = document.getElementById("account");
    temp4.classList.remove("Freed");
    
}

function changeItem(id){
    itemBefore=document.getElementById(id);
}
function switchActive(id){
    if(itemBefore != null){
        itemBefore.classList.remove("activeModifiedBg");
    }else{
        itemBefore=document.getElementById(id);
        if(!(itemBefore.classList.contains("activeModifiedBg"))){
            itemBefore.classList.add("activeModifiedBg");
        }	
    }		
}
function mengeClick(){
    var item = document.getElementsByClassName("menge");
    for(var i=0;i<item.length;i++){
        item[i].classList = item[i].classList + " mengeAktiv";
    }
}
function mengeEnd(){
    var item = document.getElementsByClassName("menge");
    for(var i=0;i<item.length;i++){
        item[i].classList.remove("mengeAktiv");
    }
}
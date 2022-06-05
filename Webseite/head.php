<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="main.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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
    </script>
</head>
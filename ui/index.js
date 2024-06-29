$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var func = event.data;
        if (func.type === "ui") {

            for (let i = 0; i < func.car_names.length; i++) {
                document.getElementById("carname"+(i+1)).innerHTML = func.car_names[i]
            }

           
        

            for (let i = 0; i < func.car_prices.length; i++) {
                document.getElementById("carlistprice"+(i+1)).innerHTML = func.car_prices[i] + "$"

            }

            if (func.status == true) {
                display(true)
            } else {
                display(false)
            }
        }

    })


    var spawnedCarName
    var spawnedCarPrice
    var counter=0

    function clear() {
        document.getElementById("centerpic").style.display = "none";
        document.getElementById("carnameCenter").style.display = "none";
        parseInt(document.getElementById("timeText").innerHTML=0)
        counter=0
    }



    $("#close").click(function () {
        $.post(`https://flow-rent/close`, JSON.stringify({}));
        

        clear()
    })



    $("#rentCar").click(function () { 
        $.post(`https://flow-rent/rentCar`, JSON.stringify({spawnedCarName,counter,spawnedCarPrice}));

        clear()
    })
    

    $("#carlistrentbutton1").click(function() {

        document.getElementById("centerpic").src = document.getElementById("carlistimg1").src;
        document.getElementById("centerpic").style.display = "flex";

        document.getElementById("carnameCenter").innerHTML = "Car Name : " + document.getElementById("carname1").innerHTML,
        document.getElementById("carnameCenter").style.display = "flex";

        spawnedCarName = document.getElementById("carname1").innerHTML
        spawnedCarPrice = document.getElementById("carlistprice1").innerHTML


    })

    $("#carlistrentbutton2").click(function() {
        document.getElementById("centerpic").src = document.getElementById("carlistimg2").src;
        document.getElementById("centerpic").style.display = "flex";

        document.getElementById("carnameCenter").innerHTML = "Car Name : " + document.getElementById("carname2").innerHTML
        document.getElementById("carnameCenter").style.display = "flex";

        spawnedCarName = document.getElementById("carname2").innerHTML
        spawnedCarPrice = document.getElementById("carlistprice2").innerHTML

    })


    $("#carlistrentbutton3").click(function() {
        document.getElementById("centerpic").src = document.getElementById("carlistimg3").src;
        document.getElementById("centerpic").style.display = "flex";

        document.getElementById("carnameCenter").innerHTML = "Car Name : " + document.getElementById("carname3").innerHTML
        document.getElementById("carnameCenter").style.display = "flex";

        spawnedCarName = document.getElementById("carname3").innerHTML
        spawnedCarPrice = document.getElementById("carlistprice3").innerHTML

    })


    $("#carlistrentbutton4").click(function() {
        document.getElementById("centerpic").src = document.getElementById("carlistimg4").src;
        document.getElementById("centerpic").style.display = "flex";

        document.getElementById("carnameCenter").innerHTML = "Car Name : " + document.getElementById("carname4").innerHTML
        document.getElementById("carnameCenter").style.display = "flex";

        spawnedCarName = document.getElementById("carname4").innerHTML
        spawnedCarPrice = document.getElementById("carlistprice4").innerHTML

    })


    $("#carlistrentbutton5").click(function() {
        document.getElementById("centerpic").src = document.getElementById("carlistimg5").src;
        document.getElementById("centerpic").style.display = "flex";

        document.getElementById("carnameCenter").innerHTML = "Car Name : " + document.getElementById("carname5").innerHTML
        document.getElementById("carnameCenter").style.display = "flex";

        spawnedCarName = document.getElementById("carname5").innerHTML
        spawnedCarPrice = document.getElementById("carlistprice5").innerHTML

    })

    $("#returnVehicle").click(function() {
        $.post(`https://flow-rent/returnVehicle`, JSON.stringify({}));

        clear()        
        
    })


    $("#leftbutton").click(function() {
        if (counter>0) {
            counter-=5
            document.getElementById("timeText").innerHTML = counter;



            ///////////// CHANGE CAR PRİCE
            document.getElementById("carlistprice1").innerHTML = parseInt(document.getElementById("carlistprice1").innerHTML)-20 + "$"
            document.getElementById("carlistprice2").innerHTML = parseInt(document.getElementById("carlistprice2").innerHTML)-20 + "$" 
            document.getElementById("carlistprice3").innerHTML = parseInt(document.getElementById("carlistprice3").innerHTML)-20 + "$"
            document.getElementById("carlistprice4").innerHTML = parseInt(document.getElementById("carlistprice4").innerHTML)-20 + "$"
            document.getElementById("carlistprice5").innerHTML = parseInt(document.getElementById("carlistprice5").innerHTML)-20 + "$"

        }

    })

    $("#rightbutton").click(function() {
        if (counter<60) {
            counter+=5
            document.getElementById("timeText").innerHTML = counter;

            ///////////// CHANGE CAR PRİCE
            document.getElementById("carlistprice1").innerHTML = parseInt(document.getElementById("carlistprice1").innerHTML)+20 + "$"
            document.getElementById("carlistprice2").innerHTML = parseInt(document.getElementById("carlistprice2").innerHTML)+20 + "$"
            document.getElementById("carlistprice3").innerHTML = parseInt(document.getElementById("carlistprice3").innerHTML)+20 + "$"
            document.getElementById("carlistprice4").innerHTML = parseInt(document.getElementById("carlistprice4").innerHTML)+20 + "$"
            document.getElementById("carlistprice5").innerHTML = parseInt(document.getElementById("carlistprice5").innerHTML)+20 + "$"
        }
        
    })


})

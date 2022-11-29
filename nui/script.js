
window.addEventListener("message", function(event){
  let data = event.data
  if (data.action == "deschideUsaCrestine") {
    document.getElementById("scoreboard").style.display = "block";
    document.querySelector("#tablepplm").innerHTML = ''+data.info;
    document.getElementById("username").innerHTML = ''+data.username;
    document.getElementById("maxplayers").innerHTML = ''+data.maxplayers;
    $('#idsiuseritext').html(data.idsiuseritext)
  }
});

$("#close").click(function () {
  $.post('https://vrp_scoreboard/exit', JSON.stringify({}));
  return
})

$(document).ready(function(){
    document.onkeyup = function (data) {
      if (data.which == 27 ) {
        document.getElementById("scoreboard").style.display = "none";
        $.post('https://vrp_scoreboard/inchideusacrestine', JSON.stringify({}));
      }
    };
});
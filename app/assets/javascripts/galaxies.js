//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
old = 0
function showGalaxyInfo(item){
  $("#galaxy_info_"+old).hide();
  $("#galaxy_info_"+item).show();
  old = item;
};

//function update_progressbar(){
//    secondsvorbei += 1
//    actualprogress = secondsvorbei / secongsgesamt
//    $("#progressbarname").width(actualprogress+"%");
//}

//setInterval(update_progressbar, 1000);
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
old = 0
function showGalaxyInfo(item){
  $("#galaxy_info_"+item).show();
  $("#galaxy_info_"+old).hide();
  old = item;
};
//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

old_building = ''
function showBuildingInfo(item){
    $("#building_info_"+old_building).hide();
    $("#building_info_"+item).show();
    old_building = item;
};

$(".building_info").hide();
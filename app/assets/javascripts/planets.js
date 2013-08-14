//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

old_building = ''
function showBuildingInfo(item){
    $("#building_info_"+old_building).hide();

    if ( item == '') {
    	$("#close_building_info").hide();
    	$("#planet_infos_shower").show();
    }else { 
    	$("#planet_infos_shower").hide();
    	$("#close_building_info").show();
	}
    $("#building_info_"+item).show();
    old_building = item;
};

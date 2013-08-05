# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
showGalaxyHelp(id) = (
  elem = document.getElementById("galaxy_help_"+id);
  elem.parent().show().children.hide();
  elem.show();
  elem.parent().show();
)
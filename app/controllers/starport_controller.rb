class StarportController < ApplicationController
  include ShipsHelper
  def index

  	@ships=Ship.all
  	@planets=Planet.all
  	@fleet=Fleet
  	@shipshelper=ShipsHelper
  end
end

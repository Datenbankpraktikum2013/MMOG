
class StarportController < ApplicationController
	before_filter :authenticate_user!

  include ShipsHelper
  def index
  	
  	@ships=Ship.all
  	@planets=Planet.where(user: current_user)
  	@fleet=Fleet
  	@shipshelper=ShipsHelper
  end

  def show
  	if Planet.find_by_id(params["id"]).user == current_user 
	  	@ships=Ship.all
	  	@planet=Planet.find_by_id(params["id"])
	  	@fleet=Fleet
	  	@shipshelper=ShipsHelper
	  else 
	  	respond_to do |format|
	  		format.html { redirect_to controller: "starport", notice: 'Not your Planet'}
	  	end
  end
  end

  def build
  	build_planet=Planet.find(params["planet"].first)
		build_fleet=Fleet.where(mission: 1, origin_planet: build_planet)

  	params["ship"].each do |p|
  		p[1].to_i.times do
  			Fleet.add_ship_to_planet(Ship.find(p[0]), Planet.find(params["planet"].first))
			end
  		#puts "Ship ID:#{p[0]} amount: #{p[1]} planet #{params["planet"].first}"
  	end

  	respond_to do |format|
	  	format.html { redirect_to controller: "starport", notice: 'Bauauftrag abgeschickt' }
	    format.json { render action: 'show', status: :created, location: @starport }
  end
  end

end

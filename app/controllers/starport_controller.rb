
class StarportController < ApplicationController
	before_filter :authenticate_user!

  include ShipsHelper
  def index
  	
  	@ships=Ship.all
  	@planets=Planet.where(user: current_user)
  	@fleet=Fleet
  	@shipshelper=ShipsHelper
    @queue=ShipBuildingQueue.where(planet_id: @planets)
    @time=Time
    
     
    
  end

  def show
  	if Planet.find_by_id(params["id"]).user == current_user
	  	@ships=Ship.all
	  	@planet=Planet.find_by_id(params["id"])
	  	@fleet=Fleet
	  	@shipshelper=ShipsHelper
      @credit=current_user.money
      
	  else 
	  	respond_to do |format|
	  		format.html { redirect_to controller: "starport", notice: 'Not your Planet'}
	  	end
  end
  end

  def build
  	build_planet=Planet.find(params["planet"])




		build_fleet=Fleet.where(mission: 1, origin_planet: build_planet)
    
    ship_array=Hash.new(Ship)


    params["ship"].each do |p|
      unless p[1].empty?
           ship_array[Ship.find(p[0])]=p[1]
         end
      #puts "Ship ID:#{p[0]} amount: #{p[1]} planet #{params["planet"].first}"
    end
    result=ShipBuildingQueue.insert(ship_array, Planet.find(params["planet"]))


  	# params["ship"].each do |p|
  	# 	p[1].to_i.times do
  	# 		ShipBuildingQueue.insert(Ship.find(p[0]), Planet.find(params["planet"].first))
			# end
  	# 	#puts "Ship ID:#{p[0]} amount: #{p[1]} planet #{params["planet"].first}"
  	# end
    # puts ":::::::::::::::::::::::::::::::::::::::::::::::::::"
    # puts ":::::::::::::::::::::::::::::::::::::::::::::::::::"
    # puts ":::::::::::::::::::::::::::::::::::::::::::::::::::"
    # puts ":::::::::::::::::::::::::::::::::::::::::::::::::::"
    # puts "result #{result}"
    # puts ":::::::::::::::::::::::::::::::::::::::::::::::::::"
    # puts ":::::::::::::::::::::::::::::::::::::::::::::::::::"
    # puts ":::::::::::::::::::::::::::::::::::::::::::::::::::"
  	respond_to do |format|
      unless(result)
        flash[:error] = "Error: You don't have enough ressources"
       format.html { redirect_to  :controller => "starport", :action => "show", :id => build_planet}
       format.json { render action: 'show', status: :created, location: @starport }
      else
  	  	format.html { redirect_to controller: "starport", notice: 'Bauauftrag abgeschickt' }
  	    format.json { render action: 'show', status: :created, location: @starport }
      end
    end
  end

end

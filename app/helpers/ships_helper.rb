module ShipsHelper

	# temporary testing method
	def self.make_testing_data
		Building.create({:planet_id => 1, :buildingtype_id => 8})
	end


#=begin
  # returns an array that contains ships that can be built
  def self.get_available_ships(planet)
  	unless planet.is_a?(Planet)
  		raise RuntimeError, "Input is no Planet"
  	end

  	user = planet.user
  	
  	available_ships = Array.new
   	existing_buildings = planet.buildings
  	existing_buildingtypes = Array.new
  	# only store the buildingtype_ids from the buildings of a planet
  	existing_buildings.each do |building|
  		existing_buildingtypes.push(building.buildingtype_id)
  	end

    

    # go through every ship and check wether the planet/user has the
    # prerequisites necessary for that ship. "Buildable" ships are stored
    # in an array
    ships = Ship.all
    ships.each do |ship|
    	buildingtypes = ship.buildingtypes
    	buildingtypes.each do |buildingtype|
    		if existing_buildingtypes.include?(buildingtype.id)
=begin    			
    			if ship.name == "Large cargo ship"
    				if user.user_setting.large_cargo_ship
    					available_ships.push(ship)
    				end
    			elsif ship.name == "Large defense platform"
    				if user.user_setting.large_defenseplattform
    					available_ships.push(ship)
    				end
    			elsif ship.name == "Cruiser"
    				if user.user_setting.cruiser
    					available_ships.push(ship)
    				end
    			elsif ship.name == "Destroyer"
    				if user.user_setting.destroyer
    					available_ships.push(ship)
    				end
    			elsif ship.name == "Deathstar"
    				if user.user_setting.deathstar
    					available_ships.push(ship)
    				end
    			else
=end
    				available_ships.push(ship)
# 				end
    		end
    	end
    end
    available_ships
  end
#=end 

end
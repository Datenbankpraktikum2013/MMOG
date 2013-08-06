module ShipsHelper


#=begin
  # returns an array that contains ships that can be built
  def self.get_available_ships(planet)
  	unless planet.is_a?(Planet)
  		raise RuntimeError, "Input is no Planet"
  	end

  	user = planet.user
  	
   	existing_buildings = planet.buildings
  	existing_buildingtypes = planet.buildings_to_hash

    # go through every ship and check wether the planet/user has the
    # prerequisites necessary for that ship. "Buildable" ships are stored
    # in an array
    available_ships = Array.new
    ships = Ship.all
    ships.each do |ship|
    	building_hash = ship.get_prerequisites
    	building_hash.each do |buildingtype_name, level|
    		if existing_buildingtypes.has_key?(buildingtype_name.to_sym) && existing_buildingtypes[buildingtype_name.to_sym] >= level
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
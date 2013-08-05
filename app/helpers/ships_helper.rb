module ShipsHelper


=begin
  # returns an array that contains ships that can be built
  def get_available_ships
    ships = Ships.all
    ships.each do |ship|
    	buildings = ship.buildingtypes

    end
  end
=end 

end
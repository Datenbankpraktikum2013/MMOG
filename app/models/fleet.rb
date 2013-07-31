class Fleet < ActiveRecord::Base
	has_many :shipfleets
	has_many :ships, :through => :shipfleets, :select => "ships.*, shipfleets.amount, shipfleets.fleet_id"
	belongs_to :start_planet, class_name: "Planet", foreign_key: "start_planet"
	belongs_to :target_planet, class_name: "Planet", foreign_key: "target_planet"
	belongs_to :origin_planet, class_name: "Planet", foreign_key: "origin_planet"
	belongs_to :user
	belongs_to :mission

  # static Method that returns a ?set? of fleets that correspond to either a planet
  # or a user
  def self.get_fleets(p)
    if p.is_a?Planet then
      Fleet.where(start_planet: p, target_planet: p)
    elsif p.is_a?User then
      Fleet.where(user_id: p)
    end
  end

  # static method that gets one fleet object
  def self.get_fleet(user, planet)
    if planet.is_a?Planet and user.is_a?User then
      # IST DAS FIRST HIER NÖTIG??????????????
      Fleet.where(start_planet: planet, target_planet: planet, user_id: user).first
    end
  end

  # returns the amount of a shiptype in one fleet
  def get_amount_of_ship(ship_id)
    var = self.ships.find(ship_id)
    if var = nil then
      return null
    else
      return var.amount
    end
  end

  # Returns a Hash of {Ship => Amount} pairs
  def get_ships()
    #STUFF
    return self.ships
  end

=begin
  #wie wird destination gepeichert?
  def move(misson, destination)
    # calculate needed energy for that flight...cases:
    # own > foreign ! Angriff
    # own > foreign ! Spionage
    # own > foreign ! Angriff
    # own > foreign ! Angriff
    #
    #
    #
    #
    #
    #
    # calculate time until arrival at foreign planet
    # calculate 
  end
=end


=begin
  # gets a Hash with ships as keys and amounts as values
  def split_fleet(ships)
    # check wether the fleet has enough ships
    # make new fleet
    # call add_ships(shiphash) on that new fleet and detroy_ships(shiphash) on the original fleet
    # returns the fleet
  end
=end

=begin
  #VIELLEICHT NUR ADD_SHIPS???????
  # fuegt einer Flotte ein Schiff hinzu
  def add_ship(ship)
    if ship.is_a?Ship then
      self.ships << ship
      #GEHT DIESE AENDERUNG?
      fid = self.fleet_id 
      sid = ship.ship_id
      # first is necessary because the return value is a collection with one object
      Shipfleet.where(fleet_id: fid, ship_id: sid).first.amount += 1
      #GEHT DIESE AENDERUNG?
    end
  end
=end

=begin
  # adds ships dependant on a hash of ship:amount
  def add_ships(shiphash)
    # Add them
  end
=end

=begin
  # destroys ships dependant on a hash of ship:amount
  def destroy_ships(shiphash)
    # check wether there are enough ships to destroy
    # destroy them
  end
=end


=begin
  #VIELLEICHT NUR DESTROY_SHIPS???????
  # destroy a ship
  def destroy_ship(ship)
    # check wether there is that ship
    # destroy it
  end
=end
end

end

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

#=begin
  # returns the amount of a shiptype in one fleet
  def get_amount_of_ship(s_id)
    amount = Shipfleet.where(fleet_id: self.id, ship_id: s_id).first.amount
    if amount == nil then
      return 0
    else
      return amount
    end
  end
#=end

=begin
  # Returns a Hash of {Ship => Amount} pairs
  def get_ships()
    if self.ships = nil
      return null
    else
      ship_hash = {}
      self.ships.each do |s|
        ship_hash[s.name] = Shipfleet.where(fleet_id: self.id, )
      end
      return shiphash
    end
  end
=end

=begin
  #wie wird destination gepeichert?
  def move(misson, destination)
    # calculate needed energy for that flight...cases:
    #
    # possible Directions
    # own > unknown
    # own > alliance
    # own > own 
    # own > enemy
    #
    # ATTACK
    # own > enemy
    #
    # COLONIZATION
    # own > unknown
    #
    # TRANSPORT
    # own > alliance
    # own > own
    # own > enemy ??????????
    #
    # TRAVEL 
    # own > unknown ????????
    # own > alliance
    # own > own
    #
    # SPY
    # own > unknown
    # own > alliance ??????? you can see it anyway??????
    # own > enemy
    #
    # calculate time until arrival at foreign planet
    # calculate 
  end
=end
  def move_to_planet()
    #self.target_planet=planet
    Resque.enqueue(1.minute, MoveFleet, self.id)
  end

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

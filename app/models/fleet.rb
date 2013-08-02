class Fleet < ActiveRecord::Base
	has_many :shipfleets
	has_many :ships, :through => :shipfleets
	belongs_to :start_planet, class_name: "Planet", foreign_key: "start_planet"
	belongs_to :target_planet, class_name: "Planet", foreign_key: "target_planet"
	belongs_to :origin_planet, class_name: "Planet", foreign_key: "origin_planet"
	belongs_to :user
	belongs_to :mission
  after_initialize :update_values

#=begin  
  # EVTL DEP ODER ARR IN DATE UMAENDERN??????????????????????????????
  # kreiert eine Flotte mit default werten. Es muss ein Planet als Argument uebergeben werden
  def initialize(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Fleet needs a Planet to be created"
    end

    super()
    self.credit = 0
    self.ressource_capacity = 0
    self.ore = 0
    self.crystal = 0
    self.storage_factor = 1.0
    self.velocity_factor = 1.0
    self.offense = 0
    self.defense = 0
    self.user_id = planet.user_id
    self.mission_id = 1
    self.departure_time = 0
    self.arrival_time = 0
    self.start_planet = planet
    self.target_planet = planet
    self.origin_planet = planet
  end
#=end


  #Returns Speed of Fleet
  def get_velocity
    if self.ships.nil?
      0
    else
      #GEHT AUCH BESTIMMT EINFACHER?!
      self.ships.sort{|s1,s2| s1.velocity <=> s2.velocity}.first.velocity

    end
  end


#=begin
  # returns the amount of a shiptype in one fleet
  # check if s is ship
  def get_amount_of_ship(ship)
    sf = Shipfleet.where(fleet_id: self, ship_id: ship).first
    if sf.nil?
      0
    else
      sf.amount
    end
  end
#=end


#=begin
  # Returns a Hash of {Ship => Amount} pairs
  def get_ships()
    ship_hash = {}
    if self.ships.nil?
      ship_hash
    else
      self.ships.each do |s|
        ship_hash[s] = Shipfleet.where(fleet_id: self, ship_id: s).first.amount
      end
      ship_hash
    end
  end
#=end

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

  def move_to_planet_in(p,t)
    Resque.enqueue_in(t.second, MoveFleet, self.id ,p.id)
  end



#=begin
  # returns a fleet, that was created from self, with the amounts of ships that are in the argument hash
  def split_fleet(ship_hash)
    
    # check wether the fleet has enough ships ( negative amounts and really ships)
    unless enough_ships?(ship_hash)
      raise RuntimeError, "Nicht genuegend Schiffe vorhanden zum splitten"
    end

    new_fleet = Fleet.new
    new_fleet.save
    new_fleet.add_ships(ship_hash)
    self.destroy_ships(ship_hash)
    return new_fleet
  end
#=end

#=begin

  #Adds Ship to Fleet in t seconds
  def add_ship_in(t,s)
    Resque.enqueue_in(t.second, AddShip, self.id ,s.id)
  end

  # fuegt einer Flotte ein Schiff hinzu
  def add_ship(s)
    unless s.is_a?Ship
      raise RuntimeError, "Input is no ship" # Fehlerbehandlung
    end

    ship_array = Shipfleet.where(fleet_id: self, ship_id: s)
    # if there is no entry of a shiptype of that fleet
    # else there is an entry, that just has to be incremented
    if ship_array.empty?
      self.ships << s
      ship_array.first.amount = 1
    else
      ship_array.first.amount += 1
    end
    ship_array.first.save
    self.update_values
  end
#=end

#=begin
  # adds ships dependant on a hash like {ship_id:amount}
  # CHECK WETHER THERE ARE NEGATIVE AMOUNTS AND FLEETS AND SHIPS EXIST
  def add_ships(ship_hash)

    new_ships = Hash.new
    
    # add ships that exist in fleet
    ship_hash.each do |key, value|
      if self.ships.include?(key)
        ship = Shipfleet.where(fleet_id: self, ship_id: key).first
        ship.amount += value
        ship.save
      else
        new_ships[key] = value
      end
    end

    # Add ships, that did not exist in the fleet before
    new_ships.each do |key, value|
      self.ships << key
      ship = Shipfleet.where(fleet_id: self, ship_id: key).first
      ship.amount = value
      ship.save
    end
    self.update_values
  end
#=end

#=begin
  # destroys ships dependant on a hash of ship_id:amount
  # CHECK WETHER THERE ARE NEGATIVE AMOUNTS AND FLEETS AND SHIPS EXIST
  def destroy_ships(ship_hash)
    unless enough_ships?(ship_hash)
      raise RuntimeError, "Not enough ships to destroy"
    end

    ship_hash.each do |key, value|
      ship = Shipfleet.where(fleet_id: self, ship_id: key).first
      ship.amount -= value
      ship.save
    end
    self.update_values
  end
#=end


#=begin
  # destroys a shiptype in the fleet
  def destroy_ship(s)
    unless s.is_a?Ship
      raise RuntimeError, "Input is no ship"
    end

    ship_array = Shipfleet.where(fleet_id: self, ship_id: s)
    # if there is no entry of a shiptype of that fleet
    # else there is an entry, that just has to be incremented
    if (ship_array.empty? || ship_array.first.amount == 0)
      return null #Fehlerbehandlung????
    else
      ship_array.first.amount -= 1
    end
    ship_array.first.save
    self.update_values
  end
#=end


  private

    # Checks wether self contains more or equal no. of ships of certain type
    # returns true if enough and false if not enough or type not existent
    # Fehlerbehandlung
    # similar to check_hash, with numberchecking
    def enough_ships?(ship_hash)
      ship_hash.each do |key, value|
        return false if value < 0
        return false unless key.is_a?(Ship)

        if self.ships.include?(key)
          return false if Shipfleet.where(fleet_id: self, ship_id: key).first.amount - value < 0
        else
          return false
        end
      end
      true
    end

    # checks if the keys are ships and the amounts are >= 0
    # returns true, if everything ok, and false in other cases
    # similar to enough_ships, without numberchecking
    def check_hash (ship_hash)
      ship_hash.each do |key, value|
        return false unless key.is_a?(Ship)
        return false if value < 0
      end
      true
    end

    # calculates changing values for the whole fleet, if there were ships added or destroyed
    # Gets called after Fleet was initialized and after adding or destroying ships
    def update_values
      ship_hash = self.get_ships
      offense = 0
      defense = 0
      ressource_capacity = 0

      ship_hash.each do |ship, amount|
        offense += ship.offense * amount
        defense += ship.defense * amount
        ressource_capacity += ship.ressource_capacity * amount
      end
      self.offense = offense
      self.defense = defense
      self.ressource_capacity = ressource_capacity
      self.save
    end
end

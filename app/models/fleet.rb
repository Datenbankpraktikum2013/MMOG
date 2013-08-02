class Fleet < ActiveRecord::Base
	has_many :shipfleets
	has_many :ships, :through => :shipfleets
	belongs_to :start_planet, class_name: "Planet", foreign_key: "start_planet"
	belongs_to :target_planet, class_name: "Planet", foreign_key: "target_planet"
	belongs_to :origin_planet, class_name: "Planet", foreign_key: "origin_planet"
	belongs_to :user
	belongs_to :mission
  after_initialize :init

  #Gets called ater Fleet was initialized
  def init
    if self.ships.nil?
      self.ressource_capacity=0
      self.offense=0
      self.defense=0
    else
      self.ressource_capacity=self.ships.sum("ressource_capacity")
      self.offense=self.ships.sum("offense")
      self.defense=self.ships.sum("defense")
    end
  end

  #Returns Speed of Fleet
  def get_velocity
    if self.ships.nil?
      0
    else
      #GEHT AUCH BESTIMMT EINFACHER?!
      self.ships.sort{|s1,s2| s1.velocity <=> s2.velocity}.first.velocity

    end
  end

=begin
  # static Method that returns a ?set? of fleets that correspond to either a planet
  # or a user
  def self.get_fleets(p)
    if p.is_a?Planet then
      Fleet.where(start_planet: p, target_planet: p)
    elsif p.is_a?User then
      Fleet.where(user_id: p)
    end
  end
=end

=begin
  # static method that gets one fleet object
  def self.get_fleet(user, planet)
    if planet.is_a?Planet and user.is_a?User then
      # IST DAS FIRST HIER NÖTIG??????????????
      Fleet.where(start_planet: planet, target_planet: planet, user_id: user).first
    end
  end
=end


#=begin
  # returns the amount of a shiptype in one fleet
  # EVTL MIT OBJEKTEN ANSTATT IDS?????????????
  def get_amount_of_ship(s_id)
    sf = Shipfleet.where(fleet_id: self.id, ship_id: s_id).first
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
        ship_hash[s.name] = Shipfleet.where(fleet_id: self, ship_id: s).first.amount
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
  # gets a Hash with ships as keys and amounts as values
  def split_fleet(ship_hash)
    
    # check wether the fleet has enough ships ( negative amounts and really ships)
    if enough_ships?(ship_hash)
      raise RuntimeError, "Nicht genuegend Schiffe vorhanden zum splitten"
    end

    new_fleet = Fleet.new
    new_fleet.save
    new_fleet.add_ships(ship_hash)
    self.destroy_ships(ship_hash)
    new_fleet
  end
#=end

#=begin

  #Adds Ship to Fleet in t seconds
  def add_ship_in(t,s)
    Resque.enqueue_in(t.second, AddShip, self.id ,s.id)
  end

  # fuegt einer Flotte ein Schiff hinzu
  # EVTL AUF SHIP_ID ALS INPUT AENDERN???
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
    self.init
    ship_array.first.save

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
  end
#=end

#=begin
  # destroys ships dependant on a hash of ship_id:amount
  # FEHLERBEHANDLUNG AN DEN ANFANG SETZEN
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
  end
#=end


#=begin
  # destroys a ship dpeendatn on the ship_id
  # MAYBE ONLY SHIP_IDS
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
  end
#=end


  # private methods
  private

  # Checks wether self contains more or equal no. of ships of certain type
  # returns true if enough and false if not enough or type not existent
  # Fehlerbehandlung
  def enough_ships?(hash)
    ships = self.ships
    hash.each do |key, value|
      return false if value < 0
      if ships.include?(key)
        return false if Shipfleet.where(fleet_id: self, ship_id: key).first.amount - value < 0
      else
        return false
      end
    end
    true
  end

  # checks if every entry is really a ship
  # def check_ships (ship_hash)

  # end

  # checks for negative amounts of the hash
  # def check_amounts (ship_hash)

  # end
end

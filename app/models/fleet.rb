class Fleet < ActiveRecord::Base
	has_many :shipfleets, dependent: :delete_all
	has_many :ships, :through => :shipfleets
	belongs_to :start_planet, class_name: "Planet", foreign_key: "start_planet"
	belongs_to :target_planet, class_name: "Planet", foreign_key: "target_planet"
	belongs_to :origin_planet, class_name: "Planet", foreign_key: "origin_planet"
	belongs_to :user
	belongs_to :mission


#=begin  
  # EVTL DEP ODER ARR IN DATE UMAENDERN??????????????????????????????
  # kreiert eine Flotte mit default werten und den aktuellen Forschungsfaktoren.
  # Es muss ein Planet als Argument uebergeben werden
  def initialize(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Fleet needs a Planet to be created"
    end

    super()
    self.credit = 0
    self.ressource_capacity = 0
    self.ore = 0
    self.crystal = 0
    #self.user = planet.user
    # ACHTUNG, NUR ZU TESTZWECKEN
    self.user = User.find(1)
    # ACHTUNG, NUR ZU TESTZWECKEN
    self.storage_factor = self.user.user_setting.increased_capacity
    self.velocity_factor = self.user.user_setting.increased_movement
    self.offense = 0
    self.defense = 0
    self.mission_id = 1
    self.departure_time = 0
    self.arrival_time = 0
    self.start_planet = planet
    self.target_planet = planet
    self.origin_planet = planet
    self.save
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

  def get_fuel_capacity
    if self.ships.nil?
      0
    else
      #GEHT AUCH BESTIMMT EINFACHER?!
      self.ships.sort{|s1,s2| s1.fuel_capacity <=> s2.fuel_capacity}.first.fuel_capacity

    end
  end

#=begin
  # calculates of a {ship => amount} hash, the building costs by returning a {ressource => cost} hash
  def Fleet.get_ressource_cost (ship_hash)
    unless hash_is_valid?(ship_hash)
      raise RuntimeError, "The Input is not valid (invalid amount or wrong objects), ships cannot be added"
    end
    ressource_hash = Hash.new(0)
    ship_hash.each do |ship, amount|
      ressource_hash[:credit_cost] += ship.credit_cost * amount
      ressource_hash[:ore_cost] += ship.ore_cost * amount
      ressource_hash[:crystal_cost] += ship.crystal_cost * amount
      ressource_hash[:crew_capacity] += ship.crew_capacity * amount
    end
    ressource_hash
  end
#=end 

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

#=begin
  #wie wird destination gepeichert?
  #ID=1 : Based
  #ID=2 : Colonizsation
  #ID=3 : Attack
  #ID=4 : Travel
  #ID=5 : Spy
  #ID=6 : Transport
  def move(mission, destination)
    unless mission.id==1
      distance=self.start_planet.getDistance(destination)
      nfuel=0
      velocity=self.get_velocity
      time=get_needed_time(velocity, distance)
      
      Ship.all.each do |ship|
        nfuel+=(get_needed_fuel(ship, time))*get_amount_of_ship(ship)
        # puts "needed fuel: #{nfuel}"
      end
    end

    if mission.id==1

    elsif mission.id==4
      
      
      self.target_planet=destination

      #Setzen der departure und arrival time!!!!!!!!!!!!!!!!

      move_to_planet_in(destination,1)

    elsif mission.id==5
      nfuel*=2
      move_to_planet_in(destination,1)
      #Spy Create Spy-Report
      move_to_planet_in(self.origin_planet,2)   
    elsif mission.id==3
      nfuel*=2
      move_to_planet_in(destination,1)
      #Spy Create Spy-Report
      move_to_planet_in(self.origin_planet,2)   
    end
      
    
      
  



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
#=end
  def fight(planet)
    defender_fleets=Fleet.where(start_planet: planet.id, target_planet: planet.id)
    defender_defense=defender_fleets.sum("defense")
    #defender_offense=defender_fleets.sum("offense")
    fight_factor=self.offense - defender_defense
    puts "defender defense: #{defender_defense} attacker offense: #{self.offense} factor: #{fight_factor}"
    #if lost...
    if fight_factor<0
      defender_new_defense=fight_factor.abs*rand(0.8 .. 1.2)
      new_offense=0


      tmp_defense=defender_defense
      while tmp_defense>defender_new_defense do
        puts "new defense #{defender_new_defense} / #{tmp_defense}"
        tmp_random_fleet=rand(0 .. ((defender_fleets.size) -1) )
        puts "fleet nr: #{tmp_random_fleet}"
        tmp_ship_index=(defender_fleets[tmp_random_fleet].ships.size) -1
        puts "shiptyp anzahl: #{tmp_ship_index}"
        del_ship_index=rand(0 .. (tmp_ship_index) )
        puts "shiptyp del: #{del_ship_index}"
        defender_fleets[tmp_random_fleet].destroy_ship(defender_fleets[tmp_random_fleet].ships[del_ship_index])
        tmp_defense=defender_fleets.sum("defense")

      end
    elsif fight_factor>0
    else
    end
  end


  def get_needed_time(velocity, distance)
      if velocity == 0 
        0
      else
        (distance/velocity)
      end
  end

  def get_needed_fuel(ship, time)
      if ship.consumption == 0 
        0
      else 
        (time/(ship.consumption))
      end 
  end

  def move_to_planet_in(p,t)
    Resque.enqueue_in(t.second, MoveFleet, self.id ,p.id)
  end


=begin
  # the actual spy action, that is triggered by the queue
  def spy_planet(own_spy_factor, planet)
    
    opp_spy_factor = planet.user.user_setting.increased_spypower
    
    # PASST DAS=???????????????
    spyreport = Spyreport.new
    spyreport.finisch_spyreport(planet, self, own_spy_factor, opp_spy_factor)
  end
=end

#=begin
  # comment me!
  # Fehlerbehandlung
  def spy_planet_in(planet)
    own_spy_factor = self.user.user_setting.increased_spypower
    #TODO
    #Resque.enqueue_in(t.second, MoveFleet, self.id ,p.id)
  end
#=end

#=begin
  # returns a fleet, that was created from self, with the amounts of ships that are in the argument hash
  # gets the values for capacity and movement factor of the fleet that it was splitted from
  def split_fleet(ship_hash)  
    unless enough_ships?(ship_hash)
      raise RuntimeError, "Not enough ships for a split"
    end
    
    # get newest technologies
    self.update_values

    new_fleet = Fleet.new(Planet.find(self.origin_planet))
    new_fleet.save
    new_fleet.add_ships(ship_hash)
    self.destroy_ships(ship_hash)
    return new_fleet
  end
#=end

#=begin
  # merges another fleet with self
  # PRUEFEN OB DIE FLOTTEN AM SELBEN ORT SIND?????
  def merge_fleet(fleet)  
    unless fleet.is_a?(Fleet)
      raise RuntimeError, "The Input is not valid (invalid amount or wrong objects), ships cannot be added"
    end

    ship_hash = fleet.get_ships
    self.add_ships(ship_hash)
    fleet.destroy
    self.update_values
  end
#=end


#=begin
  # Adds Ship to Fleet in t seconds
  # Methode aendern?????????????????????????????????? add_ships
  # Fehlerbehandlung
  def add_ship_in(t,s)
    Resque.enqueue_in(t.second, AddShip, self.id ,s.id)
  end
#=end

#=begin
  # fuegt einer Flotte ein Schiff hinzu
  # after that the fleetattributes are updated
  def add_ship(s)
    add_ships({s => 1})
  end
#=end

#=begin
  # adds ships dependant on a hash like {ship_id:amount}
  # after that the fleetattributes are updated
  def add_ships(ship_hash)
    unless hash_is_valid?(ship_hash)
      raise RuntimeError, "The Input is not valid (invalid amount or wrong objects), ships cannot be added"
    end
    # this hash contains the ships that the fleet not yet possesses.
    # Those get added after the loop
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
  # destroys a shiptype in the fleet
  # after that the fleetattributes are updated
  def destroy_ship(s)
    destroy_ships({s => 1})
  end
#=end

#=begin
  # destroys ships dependant on a hash of {ship: amount}
  # after that the fleetattributes are updated
  def destroy_ships(ship_hash)
    unless enough_ships?(ship_hash)
      raise RuntimeError, "The Input is not valid (invalid amount or wrong objects), ships cannot be destroyed"
    end

    ship_hash.each do |key, value|
      ship = Shipfleet.where(fleet_id: self, ship_id: key).first
      ship.amount -= value
      ship.save
    end
    self.update_values
  end
#=end

    # calculates changing values for the whole fleet, if there were ships added or destroyed
    # Gets called after Fleet was initialized and after adding or destroying ships
    # FACTORS NEED TO BE ADDED
  def update_values
    ship_hash = self.get_ships
    offense = 0
    defense = 0
    ressource_capacity = 0
    user = User.find(self.user_id) # IMPORTANT, ADD IT!

    ship_hash.each do |ship, amount|
      offense += ship.offense * amount
      defense += ship.defense * amount
      ressource_capacity += ship.ressource_capacity * amount
    end

     # multiply with research factors
    self.offense = offense * user.user_setting.increased_power
    self.defense = defense * user.user_setting.increased_defense
    
    # when fleet is at home, calculate the newest technologies
    if self.target_planet == self.origin_planet && self.start_planet == self.origin_planet 
      self.velocity_factor = user.user_setting.increased_movement # HYPERSPACE TECHNOLOGY???????????????
      self.storage_factor = user.user_setting.increased_capacity
      self.ressource_capacity = ressource_capacity * user.user_setting.increased_capacity
    else
      self.ressource_capacity = ressource_capacity * self.storage_factor
    end
    self.save
  end

  private

    # Checks wether self contains more or equal no. of ships of certain type
    # returns true if enough and false if not enough or type not existent
    # Fehlerbehandlung
    # similar to hash_is_valid?, with numberchecking
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
    def hash_is_valid? (ship_hash)
      ship_hash.each do |key, value|
        return false unless key.is_a?(Ship)
        return false if value < 0
      end
      true
    end

end

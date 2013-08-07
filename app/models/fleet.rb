class Fleet < ActiveRecord::Base
	has_many :shipfleets, dependent: :delete_all
	has_many :ships, :through => :shipfleets
	belongs_to :start_planet, class_name: "Planet", foreign_key: "start_planet"
	belongs_to :target_planet, class_name: "Planet", foreign_key: "target_planet"
	belongs_to :origin_planet, class_name: "Planet", foreign_key: "origin_planet"
	belongs_to :user
	belongs_to :mission

############################
#!!!!!!!!!!!!!!!!!!!!MENTION???????????????????????????
############################

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

  
#################################
############# GETTER ############
#################################

  def self.get_home_fleet(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> needs to be a planet"
    end

    Fleet.where(mission_id: 1, origin_planet: planet).first
  end

  # returns the free capacity of a fleet
  def get_free_capacity
    return diff = self.ressource_capacity - (self.ore + self.credit + self.crystal)
  end

  #Returns Speed of slowest ship in the fleet
  def get_velocity
    if self.ships.nil?
      0
    else
      velocity = self.ships.sort{|s1,s2| s1.velocity <=> s2.velocity}.first.velocity
      velocity = velocity * self.velocity_factor
    end
  end
  # returns the smallest fuel capacity of a ship in the fleet => maximum distance
  def get_fuel_capacity
    if self.ships.nil?
      0
    else
      self.ships.sort{|s1,s2| s1.fuel_capacity <=> s2.fuel_capacity}.first.fuel_capacity
    end
  end

  # returns the time in seconds that is needed to fly a distance with certain velocity
  def get_needed_time(velocity, distance)
      if velocity == 0 
        0
      else
        # EVTL HIER ZEIT PAKETE EINFÜHREN (VON 1 - 100, USW)
        (distance/velocity) * 5
      end
  end

  # ANSTATT SHIP FLOTTE MACHEN!!!!!!!!!!!!!!!!
  def get_needed_fuel(ship, time)
      if ship.consumption == 0 
        0
      else 
        (time/(ship.consumption))
      end 
  end

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



#################################
######### MISSION STUFF #########
#################################


# BASED
# own > own (no fuel)

# ATTACK
# own > enemy (2x fuel, returns automatically to origin)

# COLONIZATION
# own > unknown (2x fuel, maybe attack or stationated because alliance or yourself was there before)

# TRANSPORT
# own > alliance (2x fuel, only return to origin)
# own > own2 (1x fuel, no return intended)

# TRAVEL
# own > alliance (2x fuel, only return to origin)
# own > own2 (1x fuel

# SPY
# own > unknown (2x fuel, returns automatically to origin)
# own > alliance ??????? you can see it anyway?????? (2x fuel, returns automatically to origin)
# own > enemy (2x fuel, returns automatically to origin)

  # MOVE SOLL IMMER MIT EINER GESPLITTETEN FLEET AUFGERUFEN WERDEN...ALSO WENN EINE MISSION AUSGEWÄHLT WIRD, SOLL ERST MAL
  # EINE FLEET GESPLITTET WERDEN UND DANN DIESE BEWEGT WERDEN
  # BERECHNUNGEN UEBERDENKEN
  # missionstyp 1 AUSSCHLIEßEN
  # PLANETEN SETZEN
  # FEHLERBEHANDLUNG
  # GENERELLER ABLAUF:
  # => es wird Move(X, Y) aufgerufen, wo simple Dinge berechnet werden, wie Sprit, Time
  # => dann wird die jeweilige Methode aufgerufen, welche den Auftrag in die Resqueue packt
  #wie wird destination gepeichert?
  #ID=1 : Based
  #ID=2 : Colonization
  #ID=3 : Attack
  #ID=4 : Travel
  #ID=5 : Spy
  #ID=6 : Transport

#=begin
  def move(mission, destination, ship_hash, ore, crystal, credit)
    unless destination.is_a?(Planet)
      raise RuntimeError, "Cannot Move fleet, because Input is no Planet"
    end
    # if not at home
    unless self.origin_planet == self.start_planet && self.origin_planet == self.target_planet
      raise RuntimeError, "Cannot move fleet that is not situated at home -> You can only send it back to origin"
    end
    # throws runtimeException??????????
    fleet = self.split_fleet(ship_hash)

    distance = fleet.origin_planet.getDistance(destination)
    velocity = fleet.get_velocity * fleet.velocity_factor
    time = get_needed_time(velocity, distance)

    fleet.departure_time = Time.now.to_i
    fleet.arrival_time = fleet.departure_time + time

    energy = 0

    ships = fleet.get_ships  
    ships.each do |ship, amount|
      energy += get_needed_fuel(ship, time) * amount
    end

    #origin and start planet are ok, only target planet needs to be changed
    fleet.target_planet = destination
    home = fleet.origin_planet


    case mission.id
      when 2 then # Colonization
        energy *= 2
        # subtract energy from planet if enough, else Error
        if home.take(:Energy, energy) - energy == 0
          fleet.load_ressources(ore, crystal, credit, fleet.origin_planet)
          colonize_planet_in(fleet.arrival_time, destination)
        else
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      when 3 then # Attack
        energy *= 2
        # subtract energy from planet if enough, else Error
        if home.take(:Energy, energy) - energy == 0
          attack_planet_in(fleet.arrival_time, destination)
        else
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      when 4 then # Travel
        # subtract energy from planet if enough, else Error
        if home.take(:Energy, energy) - energy == 0
          travel_planet_in(fleet.arrival_time, destination)
        else
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      when 5 then # Spy
        energy *= 2
        # subtract energy from planet if enough, else Error
        if home.take(:Energy, energy) - energy == 0
          spy_planet_in(fleet.arrival_time, destination)
        else
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      when 6 then # Transport
        energy *= 2
        # subtract energy from planet if enough, else Error
        if home.take(:Energy, energy) - energy == 0
          fleet.load_ressources(ore, crystal, credit, fleet.origin_planet)
          transport_to_planet_in(fleet.arrival_time, destination)
        else
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      else 
        raise RuntimeError "Invalid Mission for Movement (needed 1 < id <= 6)"
    end
  end
#=end



####
# => Attack
####

#=begin  
  def attack_planet_in(time, planet)
      
  end
#=end

#=begin  
  def attack(planet)
    other_user = planet.user
    if other_user.nil? # unknown planet
      # => battle_report.do_me
      self.return_to_origin(planet)
    elsif other_user == self.user # own planet
      # => battle_report.do_me
      self.return_to_origin(planet)
    elsif other_user.alliance == self.user.alliance # alliance planet
      # => battle_report.do_me
      self.return_to_origin(planet)
    else # enemy
      # FIGHT
      # => battle_report.do_me
      #if survived:
      #  self.return_to_origin(planet)
    end
  end
#=end

#=begin
  def fight(planet)
    defender_fleets=Fleet.where(start_planet: planet.id, target_planet: planet.id)

    defender_defense=defender_fleets.sum("defense")
    #defender_offense=defender_fleets.sum("offense")
    fight_factor=self.offense - defender_defense
    #puts "defender defense: #{defender_defense} attacker offense: #{self.offense} factor: #{fight_factor}"
    #if lost...
    if fight_factor<0
      defender_new_defense=fight_factor.abs*rand(0.8 .. 1.2)
      new_offense=0


      tmp_defense=defender_defense
      while tmp_defense>defender_new_defense do
        #puts "new defense #{defender_new_defense} / #{tmp_defense}"
        tmp_random_fleet=rand(0 .. ((defender_fleets.size) -1) )
        #puts "fleet nr: #{tmp_random_fleet}"
        tmp_ship_index=(defender_fleets[tmp_random_fleet].ships.size) -1
        #puts "shiptyp anzahl: #{tmp_ship_index}"
        del_ship_index=rand(0 .. (tmp_ship_index) )
        #puts "shiptyp del: #{del_ship_index}"
        defender_fleets[tmp_random_fleet].destroy_ship(defender_fleets[tmp_random_fleet].ships[del_ship_index])
        tmp_defense=defender_fleets.sum("defense")

      end

      self.destroy

    elsif fight_factor>0
      attacker_new_offense=fight_factor.abs*rand(0.8 .. 1.2)
      new_offense=0
      tmp_offense=self.offense

      while tmp_offense>attacker_new_offense do
        tmp_ship_index=(self.ships.size) -1
        del_ship_index=rand(0 .. (tmp_ship_index) )
        self.destroy_ship(self.ships[del_ship_index])
        tmp_offense=self.offense
      end
      defender_fleets.each do |f|
        f.destroy
      end
    else
      defender_fleets.each do |f|
        f.destroy
      end
      self.destroy
    end
  end
#=end

  # def move_to_planet_in(p,t)
  #   Resque.enqueue_in(t.second, MoveFleet, self.id ,p.id)
  # end

####
# => Spy
####
#=begin
  # comment me!
  # Fehlerbehandlung
  def spy_planet_in(time, planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    if time < 0
      raise RuntimeError, "Input is invalid -> only positive timevalues are allowed"
    end
    own_spy_factor = self.user.user_setting.increased_spypower
    #TODO
    #Resque.enqueue_in(t.second, MoveFleet, self.id ,p.id)
  end

#=end

#=begin
  # the actual spy action, that is triggered by the queue
  def spy(own_spy_factor, planet)
    unless Planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end

    spyreport = Spyreport.new
    other_user = planet.user
    if other_user.nil? # unknown
      factor = 0
      type = 1
      self.return_to_origin(planet)
    elsif other_user == self.user # own planet
      factor = 0
      type = 2
      self.return_to_origin(planet)
    elsif other_user.alliance == self.user.alliance # alliance planet
      factor = 0
      type = 3
      self.return_to_origin(planet)
    else  # enemy
      factor = planet.user.user_setting.increased_spypower
      type = 4
      # the higher the spy factor, the more probable it is, that the drone survives
      r = rand 0.0..0.8
      if own_spy_factor - r < 1
        f.destroy
      else
        self.return_to_origin(planet)
      end
    end
    # make spyreport
    spyreport.finish_spyreport(planet, self, own_spy_factor, factor, type)

  end
#=end

####
# => Colonize
####
#=begin
  # comment me!
  # Fehlerbehandlung
  def colonize_planet_in(time, planet)
    unless self.get_ships.has_key?(Ship.find(10))
      raise RuntimeError, "Fleet has no Colony Ship"
    end
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    if time < 0
      raise RuntimeError, "Input is invalid -> only positive timevalues are allowed"
    end
    # add Ressource costs for Colony Ship into the fleet. 
    # Those will later be the start ressources on the new planet
    ship = Ship.find(10)
    self.load_ressources(ship.ore_cost, ship.crystal_cost, ship.credit_cost, self.origin_planet)
    #TODO
    #Resque.enqueue_in(t.second, MoveFleet, self.id ,p.id)
  end
#=end

#=begin
  # comment me!
  # Fehlerbehandlung
  def colonize(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    
    # => colonization_report = Colonizationreport.new

    other_user = planet.user
    if other_user.nil? # unknown
      # take Planet
      planet.claim(self.user)

      self.start_planet = planet
      self.target_planet = planet
      self.origin_planet = planet
      self.arrival_time = 0
      self.departure_time = 0
      self.mission_id = 1
      self.unload_ressources(planet)
      # delete the Colony Ship
      self.destroy_ship(Ship.find(10))
      self.update_values
      # => colonization_report.do_me
    elsif other_user == self.user # own planet
      # => colonization_report.do_me
      self.return_to_origin(planet)
    elsif other_user.alliance == self.user.alliance # alliance planet
      # => colonization_report.do_me
      self.return_to_origin(planet)
    else # enemy
      # => colonization_report.do_me
      self.return_to_origin(planet)
    end
  end
#=end


####
# => Travel
####

#=begin  
  def travel_to_planet_in(time, planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    if time < 0
      raise RuntimeError, "Input is invalid -> only positive timevalues are allowed"
    end
    # resqueue -> travel
  end
#=end

#=begin  
  def travel(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    # => travel_report = Travelreport.new
    other_user = planet.user
    if other_user.nil? # unknown planet
      # => travel_report.do_me muss hier bleiben, da self destroyed wird
      self.return_to_origin(planet)
    elsif other_user == self.user # own planet
      # => travel_report.do_me muss hier bleiben, da self destroyed wird
      home_fleet = Fleet.get_home_fleet(planet)
      home_fleet.mergefleet(self)
    elsif other_user.alliance == self.user.alliance # alliance planet
      # => travel_report.do_me muss hier bleiben, da self destroyed wird
      self.start_planet = self.target_planet
      self.arrival_time = 0
      self.departure_time = 0
    else # enemy
      # => travel_report.do_me muss hier bleiben, da self destroyed wird
      self.return_to_origin(planet)
    end
  end
#=end

####
# => Transport
####

#=begin  
  def transport_to_planet_in(time, planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    if time < 0
      raise RuntimeError, "Input is invalid -> only positive timevalues are allowed"
    end
    # resqueue --> planet
  end
#=end

#=begin  
  def transport(planet)
    # => transport_report = Travelreport.new
    
    other_user = planet.user
    if other_user.nil? # unknown planet
      # => transport_report.do_me
      self.return_to_origin(planet)
    elsif other_user == self.user # own planet
      self.unload_ressources(planet)
      # => transport_report.do_me
      self.return_to_origin(planet)
    elsif other_user.alliance == self.user.alliance # alliance planet
      self.unload_ressources(planet)
      # => transport_report.do_me
      self.return_to_origin(planet)
    else # enemy
      # => transport_report.do_me
      self.return_to_origin(planet)
    end
  end
#=end

####
# => Return
####

#=begin  
  # sends a fleet from planet to the planet that is stored in their origin_planet attribute
  def return_to_origin(planet)
    if planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid --> Planet needed"
    end

    velocity = self.get_velocity * self.velocity_factor
    distance = self.origin_planet.getDistance(planet)
    time = self.get_needed_time(velocity, distance)
    self.target_planet = self.origin_planet
    self.start_planet = planet
    self.departure_time = Time.now.to_i
    self.arrival_time = time + self.departure_time

    # requeueueue --> mergefleet nach self.arrival time
  end
#=end


#################################
######### MANIPULATION ##########
#################################

#=begin
  # loads ressources in a fleet after checking if there is enough space for it
  # if there is not enough space for them, it divides the 
  # additionally those ressources are subtracted from the planet, where the fleet is stationated
  # check wether the planet is self.origin??????????????????????
  def load_ressources(ore, crystal, credit, planet)
    if ore < 0 || crystal < 0 || credit < 0
      raise RuntimeError, "You cannot load negative amounts of ressources in your fleet"
    end
    unless planet.is_a?(Planet)
      raise RuntimeError, "Invalid Input -> Only Planets"
    end
    if (ore + crystal + credit) > self.get_free_capacity
      part = self.get_free_capacity / 3
      self.ore += planet.take(:Ore, part)
      self.crystal += planet.take(:Crystal, part)
      self.credit += planet.take(:Money, part)      
    else
      self.ore += planet.take(:Ore, ore)
      self.crystal += planet.take(:Crystal, crystal)
      self.credit += planet.take(:Money, credit)
    end
  end
#=end

#=begin

  # unloads all ressources in a fleet and puts them on the planet.
  # Ressources that exceed the capacity of the planet are  stored back in the fleet again
  def unload_ressources(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Invalid Input -> Only Planets"
    end
    self.ore = self.ore - planet.give(:Ore, self.ore)
    self.crystal = self.crystal - planet.give(:Crystal, self.crystal)
    self.credit = self.credit - planet.give(:Money, self.credit)
  end

#=end



  # returns a fleet, that was created from self, with the amounts of ships that are in the argument hash
  # gets the values for capacity and movement factor of the fleet that it was splitted from
  def split_fleet(ship_hash)  
    unless enough_ships?(ship_hash)
      raise RuntimeError, "Not enough ships for a split"
    end
    
    # get newest technologies
    self.update_values

    new_fleet = Fleet.new(self.origin_planet)
    new_fleet.save
    new_fleet.add_ships(ship_hash)
    self.destroy_ships(ship_hash)
    return new_fleet
  end



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



  # Adds Ship to Fleet in t seconds
  # Methode aendern?????????????????????????????????? add_ships
  # Fehlerbehandlung
  def add_ship_in(t,s)
    Resque.enqueue_in(t.second, AddShip, self.id ,s.id)
  end


#=begin
  #Adds Ship (Planet as Parameter)
  def self.add_ship_to_planet(s,p)
    f=Fleet.where(mission_id: 1, origin_planet: p)
    unless f.empty?
      f.first.add_ship(s)
    else 
      f_new=Fleet.new(p)
      f_new.add_ship(s)
      f_new.save
    end

  end
#=end



#=begin
  # fuegt einer Flotte ein Schiff hinzu
  # after that the fleetattributes are updated
  def add_ship(s)
    add_ships({s => 1})
  end



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



  # destroys a shiptype in the fleet
  # after that the fleetattributes are updated
  def destroy_ship(s)
    destroy_ships({s => 1})
  end



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


  # calculates changing values for the whole fleet, if there were ships added or destroyed
  # Gets called after Fleet was initialized and after adding or destroying ships
  def update_values
    ship_hash = self.get_ships
    offense = 0
    defense = 0
    ressource_capacity = 0
    user = self.user

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

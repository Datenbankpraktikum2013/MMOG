class Fleet < ActiveRecord::Base
	has_many :shipfleets, dependent: :delete_all
	has_many :ships, :through => :shipfleets
	belongs_to :start_planet, class_name: "Planet", foreign_key: "start_planet"
	belongs_to :target_planet, class_name: "Planet", foreign_key: "target_planet"
	belongs_to :origin_planet, class_name: "Planet", foreign_key: "origin_planet"
	belongs_to :user
	belongs_to :mission

############################
#HYPERSPACE TECHNOLOGY???????????????
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
    self.user = planet.user
    self.storage_factor = self.user.user_setting.increased_capacity
    self.velocity_factor = self.user.user_setting.increased_movement
    self.offense = 0
    self.defense = 0
    self.mission_id = 1
    self.departure_time = Time.now.to_i
    self.arrival_time = self.departure_time
    self.start_planet = planet
    self.target_planet = planet
    self.origin_planet = planet
    self.save
  end

  
  #################################
  ############# GETTER ############
  #################################
  
  # DESTROY?????????
  # calculates of a {ship => amount} hash, the building costs by returning a {ressource => cost} hash
  def self.get_ressource_cost (ship_hash)
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

  # returns the based fleet of the user that owns planet
  def self.get_home_fleet(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> needs to be a planet"
    end

    fleet = Fleet.where(mission_id: 1, origin_planet: planet).first
    return fleet
  end

  # returns the free capacity of a fleet
  def get_free_capacity
    cap = self.get_capacity - self.get_amount_of_ressources
    if cap < 0
      0
    else
      cap
    end
  end

  # returns the capacity of a fleet with respect to the technology factor
  def get_capacity
    capacity = self.ressource_capacity * self.storage_factor
  end

  # returns the amount os stored ressources
  def get_amount_of_ressources
    ress = self.ore + self.credit + self.crystal
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

  # DESTROYED
  # # returns the smallest fuel capacity of a ship in the fleet => maximum distance
  # def get_fuel_capacity
  #   if self.ships.nil?
  #     0
  #   else
  #     self.ships.sort{|s1,s2| s1.fuel_capacity <=> s2.fuel_capacity}.first.fuel_capacity
  #   end
  # end

  # returns the time in seconds that is needed to fly a distance with certain velocity
  def get_needed_time(velocity, distance)
      if velocity == 0 
        v = 0
      else
        v = (distance/velocity) * 5
      end
  end

  # returns the needed energy for a ship in certain time
  def get_needed_fuel(ship, time)
      if ship.consumption == 0 
        0
      else 
        (time/(ship.consumption))
      end
  end

  # returns the needed energy for a fleet in certain time
  def get_needed_fuel_all(time)
      fuel = 0
      self.get_ships.each do |ship, amount|
        fuel += self.get_needed_fuel(ship, time) * amount
      end
      return fuel
  end
 
  # returns the amount of a shiptype in one fleet
  # check if s is ship
  def get_amount_of_ship(ship)
    unless ship.is_a?(Ship)
      raise RuntimeError, "Input is invalid -> Ship needed"
    end

    sf = Shipfleet.where(fleet_id: self, ship_id: ship).first
    if sf.nil?
      0
    else
      sf.amount
    end
  end

  # returns the amount of a shiptype in one fleet
  # check if s is ship
  def get_amount_of_ships()
    ships = self.get_ships
    count = 0
    ships.each do |ship, amount|
      count += amount
    end
    count
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

  # Returns a Hash of {ShipNAME => Amount} pairs
  def get_ships_names()
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

  # Returns a Hash of {ShipID => Amount} pairs
  def get_ships_ids()
    ship_hash = {}
    if self.ships.nil?
      ship_hash
    else
      self.ships.each do |s|
        ship_hash[s.id] = Shipfleet.where(fleet_id: self, ship_id: s).first.amount
      end
      ship_hash
    end
  end

  # DESTROYED
  # # returns STATIC velocity (no technologies)
  # def Fleet.get_velocity_from_array(ships)
  #   if ships.nil?
  #     0
  #   else
  #     velocity = ships.sort{|s1,s2| s1.velocity <=> s2.velocity}.first.velocity
  #   end
  # end
  
  # DESTROYED
  # # returns the needed energy of ships that are stored 
  # def Fleet.get_needed_fuel_from_hash(ship_hash, time)
  #   fuel = 0
  #   ship_hash.each do |ship, amount|
  #     unless ship.consumption == 0 
  #       fuel += (time/(ship.consumption)) * amount
  #     end
  #   end
  #   fuel
  # end

  #################################
  ######### MISSION STUFF #########
  #################################

  # ++++++++++ #
  # => MOVE <= #
  # ++++++++++ #

  # General Procedure:
  # => es wird move(...) aufgerufen, wo simple Dinge berechnet werden, wie Sprit, Time, etc.
  # => dann wird die jeweilige Methode aufgerufen, welche den Auftrag in die Resque packt. Diese haben die namen X_planet_in
  # => diese wiederum führt nach der berechneten "Flugzeit" Eine Missionsmethode aus, welche den Namen der Mission tragen
  # ID=1 : Based
  # ID=2 : Colonization
  # ID=3 : Attack
  # ID=4 : Travel
  # ID=5 : Spy
  # ID=6 : Transport
  def move(mission, destination, ship_hash, ore, crystal, credit)
    unless destination.is_a?(Planet)
      raise RuntimeError, "Cannot Move fleet, because Input is no Planet"
    end
    # if not at home
    unless self.origin_planet == self.start_planet && self.origin_planet == self.target_planet
      raise RuntimeError, "Cannot move fleet that is not situated at home -> You can only send it back to origin"
    end

    fleet = self.split_fleet(ship_hash)
    distance = fleet.origin_planet.getDistance(destination)
    velocity = fleet.get_velocity
    time = get_needed_time(velocity, distance)

    fleet.departure_time = Time.now.to_i
    fleet.arrival_time = fleet.departure_time + time

    energy = fleet.get_needed_fuel_all(time)

    #origin and start planet are ok, only target planet needs to be changed
    fleet.target_planet = destination
    home = fleet.origin_planet

    case mission.id
      when 2 then # Colonization
        energy *= 2

        # subtract energy from planet if enough, else Error
        if home.energy >= energy
          home.take(:Energy, energy)
          fleet.load_ressources(ore, crystal, credit, fleet.origin_planet)
          fleet.mission = mission
          fleet.save
          fleet.colonize_planet_in(fleet.arrival_time, destination)
        else
          self.merge_fleet(fleet)
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      when 3 then # Attack
        energy *= 2
        # subtract energy from planet if enough, else Error
        if home.energy >= energy
          home.take(:Energy, energy)
          fleet.mission = mission
          fleet.save
          fleet.attack_planet_in(fleet.arrival_time, destination)
        else
          self.merge_fleet(fleet)
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      when 4 then # Travel
        # subtract energy from planet if enough, else Error
        if home.energy >= energy
          home.take(:Energy, energy)
          fleet.mission = mission
          fleet.save
          fleet.travel_to_planet_in(fleet.arrival_time, destination)
        else
          self.merge_fleet(fleet)
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      when 5 then # Spy
        energy *= 2
        # subtract energy from planet if enough, else Error
        if home.energy >= energy
          home.take(:Energy, energy)
          fleet.mission = mission
          fleet.save
          fleet.spy_planet_in(fleet.arrival_time, destination)
        else
          self.merge_fleet(fleet)
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      when 6 then # Transport
        energy *= 2
        # subtract energy from planet if enough, else Error
        if home.energy >= energy
          home.take(:Energy, energy)
          fleet.load_ressources(ore, crystal, credit, fleet.origin_planet)
          fleet.mission = mission
          fleet.save
          fleet.transport_to_planet_in(fleet.arrival_time, destination)
        else
          self.merge_fleet(fleet)
          raise RuntimeError, "Not enough energy to move the fleet"
        end
      else
        self.merge_fleet(fleet) 
        raise RuntimeError "Invalid Mission for Movement (needed 1 < id <= 6)"
      end
  end

  # ++++++++++++ #
  # => Attack <= #
  # ++++++++++++ #

  def attack_planet_in(time, planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    if time < 0
      raise RuntimeError, "Input is invalid -> only positive timevalues are allowed"
    end

    Resque.enqueue_at(time, AttackPlanet, self.id, planet.id)
  end

  
  def attack(planet)
    planet.seen_by(self.user)
    @battle_report = Battlereport.new
    
    other_user = planet.user
    if other_user.nil? # unknown planet
      @battle_report.init_battlereport({}, self, 3)
      @battle_report.finish_battlereport({}, self, false)
      self.return_to_origin(planet)
    elsif other_user == self.user # own planet
      @battle_report.init_battlereport({}, self, 5)
      @battle_report.finish_battlereport({}, self, false)
      self.return_to_origin(planet)
    elsif other_user.alliance == self.user.alliance # alliance planet
      @battle_report.init_battlereport({}, self, 4)
      @battle_report.finish_battlereport({}, self, false)
      self.return_to_origin(planet)
    else # enemy
      enemy_fleets = Fleet.where(start_planet: planet, target_planet: planet)
      @battle_report.init_battlereport(enemy_fleets, self, 0)
      self.fight(planet)
      unless self.destroyed?
        self.return_to_origin(planet)
      end
    end
  end



  def fight(planet)
    defender_fleets=Fleet.where(start_planet: planet.id, target_planet: planet.id)

    defender_defense=defender_fleets.sum("defense")
    #defender_offense=defender_fleets.sum("offense")
    fight_factor=self.offense - defender_defense
    #puts "defender defense: #{defender_defense} attacker offense: #{self.offense} factor: #{fight_factor}"
    #if lost...
    if fight_factor<0
      puts "Attacker FAIL. Calculating loss of Ships..."
      defender_new_defense=fight_factor.abs*rand(0.8 .. 1.2)
      new_offense=0
      shipamount=Hash.new(Fleet)
      defender_fleets.each do |f|
        f.user.add_score((fight_factor.abs/10).round)
        shipamount[f]=f.get_ships
        
      end
      allships=Hash.new(Fleet)

      delf=Hash.new(Fleet)
      defender_fleets.each do |f|
        allships[f]=Array.new
        shipamount=f.get_ships
        shipamount.each do |key,value|
            value.times do 
              allships[f].push key
            end
          end
        delf[f]=Hash.new(Ship)
        f.ships.each do |s|
          delf[f][s]=0
        end
        allships[f].shuffle!
      end



      tmp_defense=defender_defense

      while tmp_defense>defender_new_defense do
        #puts "new defense #{defender_new_defense} / #{tmp_defense}"
        tmp_random_fleet=rand(0 .. ((defender_fleets.size) -1) )
        #puts "fleet nr: #{tmp_random_fleet}"
        #tmp_ship_index=(defender_fleets[tmp_random_fleet].ships.size) -1
        #puts "shiptyp anzahl: #{tmp_ship_index}"
        del_ship_index=rand(0 .. (allships[defender_fleets[tmp_random_fleet]].size) -1 )
        #puts "shiptyp del: #{del_ship_index}"
        #puts "xxx: #{shipamount[allships[defender_fleets[tmp_random_fleet]][del_ship_index]]} - #{delf[defender_fleets[tmp_random_fleet]][allships[defender_fleets[tmp_random_fleet]][del_ship_index]] }"
        unless shipamount[allships[defender_fleets[tmp_random_fleet]][del_ship_index]] - delf[defender_fleets[tmp_random_fleet]][allships[defender_fleets[tmp_random_fleet]][del_ship_index]] <=0
          delf[defender_fleets[tmp_random_fleet]][allships[defender_fleets[tmp_random_fleet]][del_ship_index]]+=1
          #defender_fleets[tmp_random_fleet].destroy_ship(defender_fleets[tmp_random_fleet].ships[del_ship_index])
          tmp_defense-=allships[defender_fleets[tmp_random_fleet]][del_ship_index].defense
          allships[defender_fleets[tmp_random_fleet]].delete_at(del_ship_index)
        end
      end
      defender_fleets.each do |f|
        puts delf[f].size
        f.destroy_ships(delf[f])
      end
      puts "Generating Battlereport..."

      @battle_report.finish_battlereport(defender_fleets, nil, true)

      self.destroy

    elsif fight_factor>0
      
      unless defender_fleets.first.defense == 0
        self.user.add_score((fight_factor/10).round)
      end

      puts "Defender FAIL. Calculating loss of Ships..."
      attacker_new_offense=fight_factor.abs*rand(0.8 .. 1.2)
      new_offense=0
      tmp_offense=self.offense
      del_hash=Hash.new(Ship)
      self.ships.each do |s|
        del_hash[s]=0
      end
      #help_hash=Hash.new(Ship)
      a=0
      allships=Array.new
      shipamount=self.get_ships
      shipamount.each do |key,value|
        value.times do 
          allships.push key
        end
      end
      allships.shuffle!
      while tmp_offense>attacker_new_offense do
        a+=1
        #puts "working #{a}: #{tmp_offense} / #{attacker_new_offense}..."
        #tmp_ship_index=(self.ships.size) -1
        #del_ship_index=rand(0 .. (tmp_ship_index) )
        del_ship_index=rand( ( 0..((allships.size) -1)))
        #puts "#{shipamount[self.ships[del_ship_index]]} - #{del_hash[self.ships[del_ship_index]]}  = #{shipamount[self.ships[del_ship_index]]-del_hash[self.ships[del_ship_index]]}"
        unless  shipamount[allships[del_ship_index]] - del_hash[allships[del_ship_index]] <= 0
          del_hash[allships[del_ship_index]]+=1
          tmp_offense-=allships[del_ship_index].offense
          allships.delete_at(del_ship_index)
        end
        #self.destroy_ship(self.ships[del_ship_index])
        
      end
      #puts "size: #{del_hash.size}"
      self.destroy_ships(del_hash)
      #puts "=========================="
      defender_fleets.each do |f|
        f.destroy
      end
      self.save

      #!!!!!!!!!!!!!!! Planet.take() not working

      puts "Steeling ressources..."
      if ((self.offense/2)>=fight_factor )
        steelrate=rand(0.7 .. 1)
      else 
        steelrate=rand (0..1)
      end

      o=planet.ore
      c=planet.crystal
      m=User.find(planet.user_id).money

      wanted_crystal=((ressource_capacity/3)*rand(0.8 .. 2)).round
      wanted_ore=(ressource_capacity - wanted_crystal)*rand(0.8 .. 1.2).round
      wanted_money=ressource_capacity-(wanted_crystal+wanted_ore).round


      while ((wanted_crystal + wanted_ore + wanted_money) > ressource_capacity)
        wanted_money-=3
        wanted_crystal-=1
        wanted_money-=3
      end
      puts "trying to get: crystal: #{wanted_crystal}, ore: #{wanted_ore}, money: #{wanted_money}"

      got_crystal=planet.take(:Crystal, wanted_crystal)
      if got_crystal==0
        # got_crystal=0
        puts "no crystal"
        wanted_money+=((wanted_crystal - got_crystal )/2).round
        wanted_ore+=((wanted_crystal - got_crystal )/2).round
      # elsif (got_crystal==0) 
      #   got_crystal=wanted_crystal
      #   puts "got wanted Crystal"
      else 
        puts "got crystal #{got_crystal}"
        wanted_money+=((wanted_crystal - got_crystal )/2).round
        wanted_ore+=((wanted_crystal - got_crystal )/2).round
      end

      got_ore=planet.take(:Ore, wanted_ore)
      if got_ore==0

        # got_ore=0
        wanted_money+=((wanted_ore - got_ore ))
        puts "no ore (#{planet.ore})"
      # elsif (got_ore==0) 
      #   got_ore=wanted_ore
      #   puts "got wanted ore"
      else 
        puts "got ore #{got_ore}"
        wanted_money+=((wanted_ore - got_ore ))
        
      end

      got_money=planet.take(:Money, wanted_money)
      # if wanted_money==0
      #   got_money=0
      # elsif (got_money==0) 
      #   got_money=wanted_money
       
      # end

      self.ore=got_ore
      self.credit=got_money
      self.crystal=got_crystal
      puts "Stole: Ore: #{self.ore}, Crystal: #{self.crystal}, Money: #{self.credit}"
      self.save
      
      
      puts "Generating Battlereport..."
      #puts "xxxxxxxxxxxxxxxx #{self.get_amount_of_ship(Ship.find(3))}"
      @battle_report.finish_battlereport({}, self, false)
    else
      @battle_report.finish_battlereport({}, nil, true)
      puts "both FAIL"
      defender_fleets.each do |f|
        f.destroy
      end
      self.destroy
    end
  end

  # +++++++++ #
  # => Spy <= #
  # +++++++++ #

  def spy_planet_in(time, planet)
    unless self.get_ships == {Ship.find(7)=>1}
      raise RuntimeError, "Only one Spy Drone for spy-missions allowed"
    end
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    if time < 0
      raise RuntimeError, "Input is invalid -> only positive timevalues are allowed"
    end

    own_spy_factor = self.user.user_setting.increased_spypower

    Resque.enqueue_at(time, SpyPlanet, self.id, planet.id, own_spy_factor)
  end

  # the actual spy action, that is triggered by the queue
  def spy(own_spy_factor, planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end

    planet.seen_by(self.user)

    factor = 0.0
    other_user = planet.user
    if other_user.nil? # unknown
      self.user.add_score(5)
      type = 1
      self.return_to_origin(planet)
    elsif other_user == self.user # own planet
      type = 3
      self.return_to_origin(planet)
    elsif other_user.alliance == self.user.alliance # alliance planet
      type = 2
      self.return_to_origin(planet)
    else  # enemy
      factor = planet.user.user_setting.increased_spypower
      # the higher the spy factor, the more probable it is, that the drone survives
      r = rand 0.0..0.8
      if own_spy_factor - r < 0.8
        type = 4
      else
        self.user.add_score(5)
        type = 0
        self.return_to_origin(planet)
      end
    end
    # make spyreport
    spyreport = Spyreport.new
    spyreport.finish_spyreport(planet, self, own_spy_factor, factor, type)
    if type == 4
      self.destroy
    end
  end


  # ++++++++++++++ #
  # => Colonize <= #
  # ++++++++++++++ #

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
    
    Resque.enqueue_at(time, ColonizePlanet, self.id, planet.id)
  end

  def colonize(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end

    planet.seen_by(self.user)
    other_user = planet.user
    if other_user.nil? # unknown
      # take Planet
      planet.claim(self.user)
      self.start_planet = planet
      self.target_planet = planet
      self.origin_planet = planet
      self.arrival_time = Time.now.to_i
      self.departure_time = self.arrival_time
      self.mission_id = 1
      self.unload_ressources(planet)
      # delete the Colony Ship, it will be recycled
      self.destroy_ship(Ship.find(10))
      if self.get_capacity < self.get_amount_of_ressources
        self.ore = (self.get_capacity / 3).to_i
        self.crystal = (self.get_capacity / 3).to_i
        self.credit = (self.get_capacity / 3).to_i
        puts "due to heavy load, a few ressources got lost in the void..."
      end
      self.user.add_score(150)
      self.update_values
      type = 1
    elsif other_user == self.user # own planet
      type = 3
      self.return_to_origin(planet)
    elsif other_user.alliance == self.user.alliance # alliance planet
      type = 2
      self.return_to_origin(planet)
    else # enemy
      type = 0
      self.return_to_origin(planet)
    end
    colo_report = Colonisationreport.new
    colo_report.finish_colonisationreport(planet, self, type)

  end


  # ++++++++++++ #
  # => Travel <= #
  # ++++++++++++ #

  def travel_to_planet_in(time, planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    if time < 0
      raise RuntimeError, "Input is invalid -> only positive timevalues are allowed"
    end
    
    Resque.enqueue_at(time, TravelToPlanet, self.id, planet.id)
  end


  def travel(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end

    planet.seen_by(self.user)

    travel_report = Travelreport.new
    other_user = planet.user
    if other_user.nil? # unknown planet
      travel_report.finish_travelreport(planet, self, 1)
      self.return_to_origin(planet)
    elsif other_user == self.user # own planet
      travel_report.finish_travelreport(planet, self, 3)
      home_fleet = Fleet.get_home_fleet(planet)
      home_fleet.merge_fleet(self)
      self.user.add_score(1)
    elsif other_user.alliance == self.user.alliance # alliance planet
      travel_report.finish_travelreport(planet, self, 2)
      self.start_planet = self.target_planet
      self.arrival_time = Time.now.to_i
      self.departure_time = self.arrival_time
      self.save
      self.user.add_score(2)
    else # enemy
      travel_report.finish_travelreport(planet, self, 0)
      self.return_to_origin(planet)
    end
  end

  # +++++++++++++++ #
  # => Transport <= #
  # +++++++++++++++ #

  def transport_to_planet_in(time, planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    if time < 0
      raise RuntimeError, "Input is invalid -> only positive timevalues are allowed"
    end
    
    Resque.enqueue_at(time, TransportToPlanet, self.id, planet.id)
  end
 
  def transport(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid -> only Planets are allowed"
    end
    planet.seen_by(self.user)
    trade_report = Tradereport.new
    other_user = planet.user

    if other_user.nil? # unknown planet
      trade_report.finish_tradereport(self, planet, 1)
      self.return_to_origin(planet)
    elsif other_user == self.user # own planet
      self.unload_ressources(planet)
      trade_report.finish_tradereport(self, planet, 3)
      self.return_to_origin(planet)
      self.user.add_score(5)
    elsif other_user.alliance == self.user.alliance # alliance planet
      self.unload_ressources(planet)
      trade_report.finish_tradereport(self, planet, 2)
      self.return_to_origin(planet)
      self.user.add_score(5)
    else # enemy
      trade_report.finish_tradereport(self, planet, 0)
      self.return_to_origin(planet)
    end
  end


  # ++++++++++++ #
  # => Return <= #
  # ++++++++++++ #

  # sends a fleet from planet to the planet that is stored in their origin_planet attribute
  def return_to_origin(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Input is invalid --> Planet needed"
    end

    velocity = self.get_velocity
    distance = self.origin_planet.getDistance(planet)
    time = self.get_needed_time(velocity, distance)
    self.target_planet = self.origin_planet
    self.start_planet = planet
    self.departure_time = Time.now.to_i
    self.arrival_time = time + self.departure_time
    self.save
    Resque.enqueue_at(self.arrival_time, ReturnToOrigin, self.id)
  end

  # is called, whenever a mission should break up, i.e. the ship has to fly back home again, without executing, the task
  # the job from the queue will be cancelled and the fleet is sent back home
  # it raises an expeption whenever the fleet is on no mission
  def breakup_mission
    if self.mission.id == 1
      raise RuntimeError, "Fleet has to fly to breakup its mission"
    end
    
    # Delete Jobs
    if self.mission.id == 2
      Resque.remove_delayed(ColonizePlanet, self.id, self.target_planet.id)
    elsif self.mission.id == 3
      Resque.remove_delayed(AttackPlanet, self.id, self.target_planet.id)
    elsif self.mission.id == 4
      Resque.remove_delayed(TravelToPlanet, self.id, self.target_planet.id)
    elsif self.mission.id == 5
      Resque.remove_delayed(SpyPlanet, self.id, self.target_planet.id, user.user_setting.increased_spypower)
    else
      Resque.remove_delayed(TransportToPlanet, self.id, self.target_planet.id)
    end

    # calculate the used time till now for the flight and set it as the new arrival date for the return
    diff = Time.now.to_i - self.departure_time

    self.departure_time = Time.now.to_i
    self.arrival_time = self.departure_time + diff
    
    self.start_planet = self.target_planet
    self.target_planet = self.origin_planet
    Resque.enqueue_at(self.arrival_time, ReturnToOrigin, self.id)
    self.save
    self.user.add_score(-5)
  end


  #################################
  ######### MANIPULATION ##########
  #################################

  # loads ressources in a fleet after checking if there is enough space for it
  # if there is not enough space for them, it divides the 
  # additionally those ressources are subtracted from the planet, where the fleet is stationated
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
    self.save
  end


  # unloads all ressources in a fleet and puts them on the planet.
  # Ressources that exceed the capacity of the planet are  stored back in the fleet again
  def unload_ressources(planet)
    unless planet.is_a?(Planet)
      raise RuntimeError, "Invalid Input -> Only Planets"
    end

    self.ore = planet.give(:Ore, self.ore)
    self.crystal = planet.give(:Crystal, self.crystal)
    self.credit = planet.give(:Money, self.credit)
    self.save
  end


  # returns a fleet, that was created from self, with the amounts of ships that are in the argument hash
  # if there are ressources in the original fleet, those will only be transferred into the new fleet,
  # if the original fleet has enough space after splitting
  def split_fleet(ship_hash)  
    unless enough_ships?(ship_hash)
      raise RuntimeError, "Not enough ships for a split"
    end
    
    self.update_values
    old_capacity = self.get_capacity

    new_fleet = Fleet.new(self.origin_planet)
    new_fleet.save
    new_fleet.add_ships(ship_hash)
    self.destroy_ships(ship_hash)
    
    # if now the fleet contains to much ressources it will split the ressources and load it in the new fleet
    if self.get_capacity < self.get_amount_of_ressources
      #calculate percentage of new fleet
      factor = new_fleet.get_capacity.to_f / old_capacity.to_f
      # split ressources
      new_fleet.ore = (self.ore * factor).to_i
      new_fleet.crystal = (self.crystal * factor).to_i
      new_fleet.credit = (self.credit * factor).to_i
      self.ore = (self.ore * (1-factor)).to_i
      self.crystal = (self.crystal * (1-factor)).to_i
      self.credit = (self.credit * (1-factor)).to_i
    end

    new_fleet
  end


  # merges another fleet with self
  def merge_fleet(fleet)  
    unless fleet.is_a?(Fleet)
      raise RuntimeError, "The Input is not valid (invalid amount or wrong objects), ships cannot be added"
    end

    # add ressources to self
    self.ore += fleet.ore
    self.credit += fleet.credit
    self.crystal += fleet.crystal

    ship_hash = fleet.get_ships
    self.add_ships(ship_hash)
    fleet.destroy
    self.update_values
  end


  # Adds a Ship to Fleet in t seconds
  # Fehlerbehandlung
  def self.add_ship_in(t,s,p,id)
    Resque.enqueue_at(t, AddShip, s.id, p.id, id)
  end


  #Adds a Ship (Planet as Parameter)
  def self.add_ship_to_planet(s,p)
    f=Fleet.where(mission_id: 1, origin_planet: p)
    unless f.empty?
      btime=s.construction_time
      f.first.add_ship(s)
    else 
      f_new=Fleet.new(p)
      f_new.add_ship(s)
      f_new.save
    end

  end

  # calls add_ships with {ship =>1}
  def add_ship(ship)
    add_ships({ship => 1})
  end


  # adds ships dependant on a hash like {ship:amount}
  # after that the fleetattributes are updated
  def add_ships(ship_hash)
    unless Fleet.hash_is_valid?(ship_hash)
      raise RuntimeError, "The Input is not valid (invalid amount or wrong objects), ships cannot be added"
    end

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

  # calls destroy_ships with {ship =>1}
  def destroy_ship(ship)
    destroy_ships({ship => 1})
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
  # Gets called after Fleet was initialized and after adding or destroying ships, or splitting...merging...
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

    self.ressource_capacity = ressource_capacity

    # multiply with research factors
    self.offense = offense * user.user_setting.increased_power
    self.defense = defense * user.user_setting.increased_defense
    
    # when fleet is at home, calculate the newest technologies
    if self.target_planet == self.origin_planet && self.start_planet == self.origin_planet 
      self.velocity_factor = user.user_setting.increased_movement
      self.storage_factor = user.user_setting.increased_capacity
    end

    self.save
  end

  # Checks wether self contains more or equal no. of ships of certain type
  # returns true if enough and false if not enough or type not existent
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
  def self.hash_is_valid? (ship_hash)
    ship_hash.each do |key, value|
      return false unless key.is_a?(Ship)
      return false if value < 0
    end
    true
  end

end

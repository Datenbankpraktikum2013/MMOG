class Planet < ActiveRecord::Base

  belongs_to :user
  belongs_to :sunsystem
  has_many :buildings
  has_many :fleets

  @@MIN_SIZE = GameSettings.get("PLANET_MIN_SIZE").to_i
  @@MAX_SIZE = GameSettings.get("PLANET_MAX_SIZE").to_i
  @start_maxore
  @start_maxcrystal
  @start_maxenergy
  @cache_buildings
  @cache_buildings_hash
  @upgradable_buildings
  after_initialize :init

  #
  # Method to initialize a new planet
  #
  def init

=begin
    Positions in array @spec for factors:
    0 orefactor
    1 energyfactor
    2 populationfactor
    3 credtitfactor
    4 crysstalfactor
    5 lagerfactor
    6 buildfactor
    7 forschungfactor
=end
    @spec = [1, 1, 1, 1, 1, 1, 1, 1]
    self.calc_spec

    if self.name.nil?
      #self.under_construction = false

      if self.size.nil?
        self.size = Random.rand(@@MAX_SIZE-@@MIN_SIZE) + @@MIN_SIZE
      end
      self.ore = 20 if self.ore.nil?
      self.maxore = 100 if self.maxore.nil?
      self.maxcrystal = 1 if self.maxcrystal.nil?
      self.maxenergy = 200 if self.maxenergy.nil?
      self.crystal = 0 if self.crystal.nil?
      self.energy = 50 if self.energy.nil?
      self.population = self.size/10 if self.population.nil?
      self.maxpopulation = self.size/2 if self.maxpopulation.nil?

      #Creates random Planet name
      self.name = PlanetsHelper.namegen

      #Creates specialties for Planet
      unless self.special.nil? || self.special == 0
        self.special = Random.rand(7) + 1
        #Oreplanet
        if self.special == 1
           self.ore = 50
           @spec[0] = 1.3
        #Loveplanet   
        elsif self.special == 2
           @spec[1] = 1.3
        #Creditplanet   
        elsif self.special == 3
           @spec[3] = 1.3
        #Crystalplanet   
        elsif self.special == 4
           self.size = @@MIN_SIZE + Random.rand(@@MIN_SIZE*2)
           self.population = self.size/10
           self.maxpopulation = self.size/2
           self.maxore = 75
           self.maxenergy = 175
           self.maxcrystal = 5
           @spec = [0.5, 0.5, 0.5, 0.5, 1, 1, 1,1]
        #Buildplanet
        elsif self.special == 5
           self.ore = 50
           self.energy = 100
           @spec[6] = 0.7
        #Lagerplanet   
        elsif self.special == 6
           self.maxore = 200
           self.maxenergy = 400
           self.maxcrystal = 5
           @spec[5] = 1.3
        #Scienceplanet      entfernt... fehlerhaft noch aktiv gewesen
        #elsif self.special == 7
        #   @spec[7] = 1.3
        #Energieplanet   
        else self.special == 7 #8
          self.energy = 100
           @spec[2] = 1.3
        end   
      else
         
        self.size = (@@MAX_SIZE/2)
        self.ore = 20
        self.special = 0
        self.maxore = 100
        self.maxcrystal = 1
        self.maxenergy = 200
        self.crystal = 0
        self.energy = 50
        self.population = 1000
        self.maxpopulation = 5000
        
      end
        @start_maxore = maxore
        @maxcrystal = maxcrystal
        @start_maxenergy = maxenergy
    end
  end

  def calc_spec
      @start_maxore = 100
      @start_maxcrystal = 1
      @start_maxenergy = 200
    if self.special == 1
      @spec[0] = 1.3
      #Loveplanet
    elsif self.special == 2
      @spec[1] = 1.3
      #Creditplanet
    elsif self.special == 3
      @spec[3] = 1.3
      #Crystalplanet
      @start_maxore = 75
      @start_maxcrystal = 5
      @start_maxenergy = 175
    elsif self.special == 4
      @spec = [0.5, 0.5, 0.5, 0.5, 1, 1, 1,1]
      #Buildplanet
    elsif self.special == 5
      @spec[6] = 0.7
      #Lagerplanet
    elsif self.special == 6
      @start_maxore = 200
      @start_maxcrystal = 5
      @start_maxenergy = 400
      @spec[5] = 1.3
      #Scienceplanet
    elsif self.special == 7
      @spec[7] = 1.3
      #Energieplanet
    else self.special == 8
      @spec[2] = 1.3
    end
  end


  def mention()
    self.sunsystem.mention()
    #Hier weitere Aktionen starten: z.B. Rohstoffproduktion, falls gestoppt wurde
  end


  def claim(user)
    if self.user.nil? then #&& self.user.planets.count == 0
      self.seen_by(user)
      self.user = user;
      self.create_building_job(:Oremine)
      self.under_construction = false
      self.create_building_job(:Headquarter)
      self.under_construction = false   
      self.create_building_job(:Powerplant)
      self.under_construction = false
      self.create_building_job(:City)
      self.under_construction = false
      self.create_production_job;
    else
      self.user = user;
    end
    self.save
  end

  #@param type Name der Produktionsstaette ("Eisenmine", "Haus", ...)
  def get_production(type)
    btype = Buildingtype.where(name: type.to_s)
    production_building = self.buildings.where(buildingtype_id: btype).first
    return 0 if production_building.nil? 
    prod_building_type = Buildingtype.where(id:production_building.buildingtype_id).first
    prod = prod_building_type.production
    
    #sci_factor =1
    if type == :Oremine
      sci_factor = self.user.get_ironproduction
      c = sci_factor * prod * @spec[0]
      return c
    end

    if type == :City
      c = @spec[2] * prod
      return c
    end

    if type == :Headquarter
      sci_factor = self.user.get_income
      c = sci_factor * @spec[3] * (self.population / 100) * prod 
      return c
    end

    if type == :Powerplant
      sci_factor = self.user.get_energy_efficiency
      c = sci_factor * prod * @spec[1] 
      return c
    end

    if type == :Crystalmine
      c = @spec[4] * prod
      return c
    end
  end

  #Method which increases and updates all the resources a player has every ...Minute
  def update_resources
    if energy > 0 
      
      #
      # updates ore production
      #
      ore_production = self.get_production(:Oremine).to_i
      if ore_production.integer? then
        if (self.ore + ore_production) < self.maxore then
          self.ore += ore_production
        else
          self.ore = self.maxore
        end
      end

      #
      # updates population
      #
      city_population = self.get_production(:City).to_i
      if city_population.integer? then
        if (self.population + city_population) < self.maxpopulation then
          self.population += city_population
        else
          self.population = self.maxpopulation
        end
      end

      #
      # updates crystal
      #
      crystal_production = self.get_production(:Crystalmine).to_i
      if crystal_production.integer? then
        if (self.crystal + crystal_production) < self.maxcrystal then
          self.crystal += crystal_production
        else
          self.crystal = self.maxcrystal
        end
      end
      #self.save

      #
      # updates money 
      #
      income = self.get_production(:Headquarter).to_i
      owner = self.user
      owner.money += income
      owner.save
      

      # Energy costs 
      @structures = self.buildings
      ener_usage = 0
      @structures.each do |str|
        building_typ = Buildingtype.find_by_id(str.buildingtype_id)
        ener_usage += building_typ.energyusage
        self.energy -= ener_usage
      end 

    end

    
    

      #
      # Energy costs and production
      #
      power_production = self.get_production(:Powerplant).to_i
      if (self.energy + power_production) < self.maxenergy
        self.energy += power_production
      else
        self.energy = self.maxenergy
      end
    
 
    # Repeat Job imediately
    self.create_production_job

  end

  def create_building_job(type)
    return false if type == :Crystalmine && self.special != 4
    return false if self.under_construction
    buildingtype_arr = Buildingtype.where(name: type.to_s)
    id_list = []
    buildingtype_arr.each do |x|
      id_list << x.id
    end
    upgrade_me = self.buildings.where(buildingtype_id: id_list).first

    return false if !upgrade_me.nil? && !upgrade_me.verifies_upgrade_requirements? || upgrade_me.nil? && !self.verifies_new_building?(type)

    if upgrade_me.nil?
      build_time = Buildingtype.where(name: type.to_s, level:1).first.build_time
      build_me = Buildingtype.where(name: type.to_s, level:1).first
    else  
      upgrade_me = upgrade_me.buildingtype_id
      my_future_me = Buildingtype.find_by_id(upgrade_me)
      build_me = Buildingtype.where(name:type ,level:(my_future_me.level)+1).first
      build_time = build_me.build_time
    end

    if  (0 > self.ore - build_me.build_cost_ore || 0 > self.crystal - build_me.build_cost_crystal ||  0 > self.population - build_me.build_cost_population || 0 > self.user.money - build_me.build_cost_money)
      return false
    end   
    self.ore -= build_me.build_cost_ore
    self.crystal -= build_me.build_cost_crystal
    self.population -= build_me.build_cost_population
    self.user.money -= build_me.build_cost_money
    self.user.save

    id_array = []
    id_array << self.id
    id_array << build_me.id
    self.under_construction = true
    
    self.save

    Resque.enqueue_in(build_time.second, BuildBuildings, id_array)
  end

  def delete_building_job(type_id)
    id_array = []
    id_array << self.id
    id_array << type_id
    if Resque.remove_delayed(BuildBuildings, id_array) == 1
      self.under_construction = false
      self.save
      destroy_me = Buildingtype.find(type_id)
      give(:Ore, destroy_me.build_cost_ore/2)
      give(:Crystal, destroy_me.build_cost_crystal/2)
      give(:Population, destroy_me.build_cost_population/2)
      give(:Money, destroy_me.build_cost_money/2)

    end
    
  end

  def depot_size_increase(prod_size)
     self.maxore = @start_maxore * prod_size * @spec[5]
     self.maxcrystal = @start_maxcrystal * prod_size * @spec[5]
     self.maxenergy = @start_maxenergy * prod_size * @spec[5]
    self.save
  end

  def build_building(buildingtype_id)
    self.reset_building_cache
    self.under_construction = false
    self.save
    
    return false if buildingtype_id.nil? || !buildingtype_id.integer?
    build_me = Buildingtype.where(id: buildingtype_id).first
    return false if build_me.nil?
    builds = self.buildings
    builds.each do |b|
      btype = b.buildingtype
      if btype.name == build_me.name && btype.level + 1 == build_me.level
        b.buildingtype = build_me

        if btype.name== "Depot"
          depot_size_increase(btype.production)
        end  
        b.save
        return true
      end
    end
    if build_me.level == 1 then
      Building.create(buildingtype_id: buildingtype_id, planet: self)
      if build_me.name == "Depot"
        depot_size_increase(build_me.production)
      end
      return true
    end
    return false
  end

  def create_production_job()
    Resque.enqueue_in(10.second, ProduceResources, self.id)
  end

  def getDistance(other)
    if other.is_a?Planet then

      dist1 = self.sunsystem.getDistance(other.sunsystem)
      if dist1 < 0 then
        return -1
      end

      if(dist1 == 0) then
        if self.z < other.z then
          dist2 = other.z - self.z
        else
          dist2 = self.z - other.z
        end
      else
        #dist2 = ((self.z + other.z)**3)/((self.z - other.z)**2 + 1)
        dist2 = self.z + other.z
      end
      dist1 + dist2
    else
      -1
    end
  end

  def research_level
    return self.buildings_to_hash[:ResearchLab]
  end

  def buildings_to_hash
    if !(GameSettings.get("caching?")) || @cache_buildings_hash.nil? || @cache_buildings_hash.empty? then
      @cache_buildings_hash = {:Oremine => 0, :ResearchLab => 0, :City => 0, :Powerplant =>  0, :Crystalmine => 0, :Headquarter => 0, :Starport => 0, :Depot => 0}
      builds = self.buildings
      builds.each do |b|
        btype = b.buildingtype
        @cache_buildings_hash[btype.name.to_sym] = btype.level
      end
    end
    return @cache_buildings_hash
  end

  def reset_building_cache
    @cache_buildings = {}
    @cache_buildings_hash = {}
    @upgradable_buildings = nil
  end


  def upgradable_buildings_to_hash
    if !(GameSettings.get("caching?")) || @upgradable_buildings.nil? || @upgradable_buildings.empty? then
      @upgradable_buildings = []
      hashed_b = self.buildings_to_hash
      hashed_b.each do |h|
        if h[1] == 0 then
          @upgradable_buildings << h[0] if self.verifies_new_building?(h[0])
        end
      end
      bs = self.buildings
      bs.find_each do |b|
        @upgradable_buildings << b.buildingtype.name.to_sym if b.verifies_upgrade_requirements?
      end
    end
    return @upgradable_buildings
  end

  def give(type, number)
    return 0 if number <= 0
    back = 0
    if type == :Ore then
      old = self.ore.to_i
      if old + number.to_i >= self.maxore.to_i then
        self.ore = self.maxore
        back = number + old - self.maxore
      else
        self.ore = old + number.to_i
      end

    elsif  type == :Crystal then
      old = self.crystal
      if old + number >= self.maxcrystal then
        self.crystal = self.maxcrystal
        back = number + old - self.maxcrystal
      else
        self.crystal = old + number
      end

    elsif type == :Population then
      old = self.population
      if old + number >= self.maxpopulation then
        self.population = self.maxpopulation
        back = number + old - self.maxpopulation
      else
        self.population = old + number
      end

    elsif type == :Energy then
      old = self.energy
      if old + number >= self.maxenergy then
        self.energy = self.maxenergy
        back = number + old - self.maxenergy
      else
        self.energy = old + number
      end

    elsif type == :Money then
      u = self.user
      if u.nil? then
        back = number
      else
        u.money = u.money + number
        u.save
      end
    else
      back = number
    end
    self.save
    return back
  end

  def take(type, number)
    return 0 if number <= 0
    back = 0
    if type == :Ore then
      old = self.ore
      if old < number then
        self.ore = 0
        back = old
      else
        self.ore = old - number
        back = number
      end

    elsif type == :Crystal then
      old = self.crystal
      if old < number then
        self.crystal = 0
        back = old
      else
        self.crystal = old - number
        back = number
      end

    elsif type == :Population then
      old = self.population
      if old < number then
        self.population = 0
        back = old
      else
        self.population = old - number
        back = number
      end

    elsif type == :Energy then
      old = self.energy
      if old < number then
        self.energy = 0
        back = old
      else
        self.energy = old - number
        back = number
      end

    elsif type == :Money then
      u = self.user
      if u.nil? then
        back = 0
      else
        old = u.money
        if u.money >= number then
          u.money = old - number
          back = number
        else
          u.money = 0
          back = old
        end
        u.save
      end

    else
      back = 0
    end
    self.save
    return back
  end

  def verifies_new_building?(type)
    hashed_b = self.buildings_to_hash
    return false if !hashed_b.include?(type) || hashed_b[type] > 0
    btypenext = Buildingtype.where(name: type.to_s, level: 1)
    return false if btypenext.nil? || btypenext.empty?
    btype = btypenext.first()
    required = btype.requirements
    return true if required.nil? || required.empty?
    allow = true

    required.each do |req|
      if req.level > hashed_b[req.name.to_sym] then
        allow = false
      end
    end
    return allow
  end

  def get_buildings
    if !(GameSettings.get("caching?")) || @cache_buildings.nil? || @cache_buildings.empty? then
      @cache_buildings = []
      self.buildings.each do |b|
        @cache_buildings << b
      end
    end
    return @cache_buildings
  end

  def get_building(type)
    builds = self.get_buildings
    out = nil
    builds.each do |b|
      if b.buildingtype.name == type.to_s then
        out = b
      end
    end
    return out
  end

  def ressources_to_hash
    return {:Ore => self.ore, :Crystal => self.crystal, :Energy=> self.energy, :Money => self.user.money, :Population => self.population}
  end

  def seen_by(user)
    self.mention()
    s = self.sunsystem
    s.users << user if !user.nil? && !s.is_visible_by?(user)
  end

  def is_visible_by?(user)
    return false if user.nil?
    return user.visible_planets.include?(self)
  end

  def is_home_planet?
    return false if self.user.nil?
    return self.user.home_planet == self
  end

  def set_home_planet
    user.home_planet = self if !self.user.nil?
  end

end

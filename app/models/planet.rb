class Planet < ActiveRecord::Base

  belongs_to :user
  belongs_to :sunsystem
  has_many :buildings
  has_many :fleets

  MIN_SIZE = 10000
  MAX_SIZE = 100000

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
      self.under_construction = false


      self.size = Random.rand(MAX_SIZE-MIN_SIZE) + MIN_SIZE if self.size.nil?
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
           self.size = MIN_SIZE + Random.rand(3000)
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
        #Scienceplanet
        elsif self.special == 7
           @spec[7] = 1.3
        #Energieplanet   
        else self.special == 8
          self.energy = 100
           @spec[2] = 1.3
        end   
      else
         
        self.size = (MAX_SIZE/2)
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
    end
  end


  def calc_spec
    if self.special == 1
      @spec[0] = 1.3
      #Loveplanet
    elsif self.special == 2
      @spec[1] = 1.3
      #Creditplanet
    elsif self.special == 3
      @spec[3] = 1.3
      #Crystalplanet
    elsif self.special == 4
      @spec = [0.5, 0.5, 0.5, 0.5, 1, 1, 1,1]
      #Buildplanet
    elsif self.special == 5
      @spec[6] = 0.7
      #Lagerplanet
    elsif self.special == 6
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
    self.mention()
  end

  def spec
    puts @spec
  end

  #@param type Name der Produktionsstaette ("Eisenmine", "Haus", ...)
  def get_production(type)
    # TODO Calculate production
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
      c = sci_factor * @spec[3] * (self.population / 100)# * prod 
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

  def get_building_factor_of(type)
    # TODO Calculate the factor of buildingspeed
    return 1
  end

  #Method which increases and updates all the resources a player has every ...Minute
  def update_resources
    if energy > 0 
      
      #
      # updates ore production
      #
      ore_production = self.get_production(:Oremine)
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
      city_population = self.get_production(:City)
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
      crystal_production = self.get_production(:Crystalmine)
      if crystal_production.integer? then
        if (self.crystal + crystal_production) < self.maxcrystal then
          self.crystal += crystal_production
        else
          self.crystal = self.maxcrystal
        end
      end
      self.save

      #
      # updates money 
      #
      income = self.get_production(:Headquarter)
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
      power_production = self.get_production(:Powerplant)
      if (self.energy + power_production) < self.maxenergy
        self.energy += power_production
      else
        self.energy = self.maxenergy
      end
    
 
    # Repeat Job imediately
    self.create_production_job

  end

  def create_building_job(type)
    return false if self.under_construction
    buildingtype_arr = Buildingtype.where(name: type.to_s)
    id_list = []
    buildingtype_arr.each do |x|
      id_list << x.id
    end
    upgrade_me = self.buildings.where(buildingtype_id: id_list).first

    return false if !upgrade_me.nil? && !upgrade_me.verifies_upgrade_requirements?

    if upgrade_me.nil?
      build_time = Buildingtype.where(name: type.to_s, level:1).first.build_time
      build_me = Buildingtype.where(name: type.to_s, level:1).first.id
    else  
      upgrade_me = upgrade_me.buildingtype_id
      my_future_me = Buildingtype.find_by_id(upgrade_me)
      build_time = Buildingtype.where(name:type, level:(my_future_me.level)+1).first.build_time
      build_me = Buildingtype.where(name:type ,level:(my_future_me.level)+1).first.id
    end

    if  (0 > self.ore - build_me.build_cost_ore || 0 > self.crystal - build_me.build_cost_crystal ||  0 > self.population - build_me.build_cost_population || 0 > User.find(self.user_id).money - build_me.build_cost_money)
      return false
    end   
    self.ore -= build_me.build_cost_ore
    self.crystal -= build_me.build_cost_crystal
    self.population -= build_me.build_cost_population
    User.find(self.user_id).money -= build_me.build_cost_money
    User.find(self.user_id).save

    id_array = []
    id_array << self.id
    id_array << build_me.id
    self.under_construction = true
    puts "ITS True eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee NOW #{self.under_construction}"
    self.save
    Resque.enqueue_in(build_time.second,BuildBuildings, id_array)

  end

  def build_building(buildingtype_id)
    #destroy_me = self.buildings.where(name: Buildingtype.where(id: id).first.name).first.id
    #destroy_me.destroy unless destroy_me.nil?
    #reborn_me = Building.create(buildingtype_id: id, planet: seld.id)
    self.under_construction = false
    self.save

    puts "ITS FFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALSE NOW #{self.under_construction}"
    return false if buildingtype_id.nil? || !buildingtype_id.integer?
    build_me = Buildingtype.where(id: buildingtype_id).first
    return false if build_me.nil?
    builds = self.buildings
    buildings.each do |b|
      if b.buildingtype.name == build_me.name && b.buildingtype.level + 1 == build_me.level
        b.buildingtype = build_me
        b.save
        return true
      end
    end
    if build_me.level == 1 then
      Building.create(buildingtype_id: buildingtype_id, planet: self)

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
    out = {:Oremine => 0, :ResearchLab => 0, :City => 0, :Powerplant =>  0, :Crystalmine => 0, :Headquarter => 0, :Starport => 0, :Depot => 0}
    self.buildings.each do |b|
      btype = b.buildingtype
      out[btype.name.to_sym] = btype.level
    end
    return out
  end

  def give(type, number)
    back = 0
    if type == :Ore then
      old = self.ore
      if old + number >= self.maxore then
        self.ore = self.maxore
        back = self.maxore - old
      else
        self.ore = old + number
      end

    elsif  type == :Crystal then
      old = self.crystal
      if old + number >= self.maxcrystal then
        self.crystal = self.maxcrystal
        back = self.maxcrystal - old
      else
        self.ore = old + number
      end

    elsif type == :Population then
      old = self.population
      if old + number >= self.maxpopulation then
        self.population = self.maxpopulation
        back = self.maxpopulation - old
      else
        self.population = old + number
      end

    elsif type == :Energy then
      old = self.energy
      if old + number >= self.maxenergy then
        self.energy = self.maxenergy
        back = self.maxenergy - old
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

    end
    return back
  end

  def take(type, number)
    back = 0
    if type == :Ore then
      old = self.ore
      if old < number then
        self.ore = 0
        back = old
      else
        self.ore = old - number
      end

    elsif type == :Crystal then
      old = self.crystal
      if old < number then
        self.crystal = 0
        back = old
      else
        self.crystal = old - number
      end

    elsif type == :Population then
      old = self.population
      if old < number then
        self.population = 0
        back = old
      else
        self.population = old - number
      end

    elsif type == :Energy then
      old = self.energy
      if old < number then
        self.energy = 0
        back = old
      else
        self.energy = old - number
      end

    elsif type == :Money then
      u = self.user
      if u.nil? then
        back = number
      else
        old = u.money
        if u.money >= number then
          u.money = old - number
        else
          u.money = 0
          back = old
        end
        u.save
      end

    else
      back = number
    end
    return back
  end

end

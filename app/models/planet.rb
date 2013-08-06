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
    if self.name.nil?
      self.name = PlanetsHelper.namegen
    end

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


  def mention()
    self.sunsystem.mention()
    #Hier weitere Aktionen starten: z.B. Rohstoffproduktion, falls gestoppt wurde
  end


  def claim(user)
    if self.user.nil?
      self.user = user;
      self.create_building_job(:Oremine)
      self.create_building_job(:Headquarter)
      self.create_building_job(:Powerplant)
      self.create_building_job(:City)
      self.create_production_job;
    else
      self.user = user;
    end
  end


  #@param type Name der Produktionsstaette ("Eisenmine", "Haus", ...)
  def get_production(type)
    # TODO Calculate production
    btype = Buildingtype.where(name: type.to_s)
    production_building = self.buildings.where(buildingtype_id: btype).first
    return 0 if production_building.nil? 
    prod_building_type = Buildingtype.where(id:production_building.buildingtype_id).first
    prod = prod_building_type.production
    
    sci_factor =1
    if type == :Oremine
      #sci_factor = self.user.get_ironproduction
      c = sci_factor * prod * @spec[0]
      return c
    end

    if type == :City
      c = @spec[2] * prod
      return c
    end

    if type == :Headquarter
      #sci_factor = self.user.get_income
      c = sci_factor * @spec[3] * (self.population / 100)# * prod 
      return c
    end

    if type == :Powerplant
      #sci_factor = self.user.get_energy_efficiency
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

      #
      # updates money 
      #
      income = self.get_production(:Headquarter)
      owner = self.user
      owner.money += income
      owner.save
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
    
    @structures = self.buildings
    ener_usage = 0
    @structures.each do |str|
      building_typ = Buildingtype.find_by_id(str.buildingtype_id)
      ener_usage += building_typ.energyusage
    end

    self.energy -= ener_usage 
 
    # Repeat Job imediately
    self.create_production_job

  end

  def create_building_job(type)
    buildingtype_arr = Buildingtype.where(name: type.to_s)
    id_list = []
    buildingtype_arr.each do |x|
      id_list << x.id
    end
    upgrade_me = self.buildings.where(buildingtype_id: id_list).first
    
    if upgrade_me.nil?
      build_time = Buildingtype.where(name: type.to_s, level:1).first.build_time
      build_me = Buildingtype.where(name: type.to_s, level:1).first.id
      puts "1: " + build_me.to_s
    else  
      upgrade_me = upgrade_me.id
      puts "2: "+ upgrade_me.to_s
      #build_time = Buildingtype.where(name:type level:upgrade_me.level+1).build_time
      #build_me = Buildingtype.where(name:type level:upgrade_me.level+1).id
    end
    id_array = []
    id_array << self.id
    id_array << build_me
    puts "ID ARRAY: #{id_array}"
    Resque.enqueue_in(2.second,BuildBuildings, id_array)

  end

  def build(buildingtype_id)
    #destroy_me = self.buildings.where(name: Buildingtype.where(id: id).first.name).first.id
    #destroy_me.destroy unless destroy_me.nil?
    #reborn_me = Building.create(buildingtype_id: id, planet: seld.id)
    return false if buildingtype_id.nil? || !buildingtype_id.integer?
    build_me = Buildingtype.where(id: buildingtype_id).first
    return false if build_me.nil?
    builds = self.buildings
    buildings.each do |b|
      if b.buildingtype.name == build_me.name && b.buildingtype.level + 1 == build_me.level
        b.buildingtype = build_me
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
    #puts "PLANETEN ID:#{self.id}"
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
        dist2 = ((self.z + other.z)**3)/((self.z - other.z)**2 + 1)
      end
      dist1 + dist2
    else
      -1
    end
  end

  def research_level

   self.buildings.each do |t|
     if t.buildingtype.name == "ResearchLab"
       a = t.buildingtype.level
     end
   end


  end

end

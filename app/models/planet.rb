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
      self.name = (0...8).map{(65 + Random.rand(26)).chr}.join
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
      seld.user = user;
      seld.create_building_job(:Oremine)
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
    puts"type: #{type} typetos #{type.to_s}"
    btype = Buildingtype.where(name: type.to_s)
    puts "btype: #{btype.to_s}"
    production_building = self.buildings.where(buildingtype_id: btype).first
    return 0 if production_building.nil? 
    puts "production_building: #{production_building}"
    prod_building_type = Buildingtype.where(id:production_building.buildingtype_id).first
    puts "prod_building_type: #{prod_building_type}"
    prod = prod_building_type.production
    puts "prod: #{prod}"
    
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
      puts "Test"
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
        puts "#{ore_production}"
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
      puts "INCOME: #{income}!!!!!!!!!!!!!!!"
      puts "#SPEC: #{@spec[3]}HHHHHHHHHHHHH"
      puts "#{User.find_by id: self.user_id}"
      #owner = User.find_by_id (self.user.id)
      owner = self.user
      puts "OOOOOOOOOOOOOOOOWWWWWWWNER ::::#{owner}"
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
    #self.create_production_job

  end

  def create_building_job(type)
    upgrade_me = self.buildings.where(name: type)
    
    if upgrade_me.nil?
      build_time = Buildingtype.where(name:type, level:1).build_time
      build_me = Buildingtype.where(name:type, level:1).id
    else  
      upgrade_me = upgrade_me.first.id 
      #build_time = Buildingtype.where(name:type level:upgrade_me.level+1).build_time
      #build_me = Buildingtype.where(name:type level:upgrade_me.level+1).id
    end
    Resque.enqueue_in(buildtime.minute,BuildBuildingjob, id_array(self.id,build_me))

  end

  def build(id)
    destroy_me = self.buildings.where(name: Buildingtype.where(id: id).first.name).first.id
    destroy_me.destroy unless destroy_me.nil?
    reborn_me = Building.create(buildingtype_id: id, planet: seld.id)
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


end

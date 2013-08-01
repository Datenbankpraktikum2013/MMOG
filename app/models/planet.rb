class Planet < ActiveRecord::Base

  belongs_to :user
  belongs_to :sunsystem
  has_many :buildings
  has_many :fleets

  MIN_SIZE = 123456789
  MAX_SIZE = 987654321
  SPEC_CONST = 1.02


  def initialize(pla_name, pla_z, pla_specialty, pla_sunsystem_id)
    self.name = pla_name
    self.z = pla_z
    if pla_specialty
      #Random für planetsize
    else
      #Startgebaeude muessen noch initialisiert werden 
      self.size = (MAX_SIZE + MIN_SIZE)/2
      self.ore = 20
      self.maxore = 100
      self.crystal = 0
      self.maxcrystal = 1
      self.energy = 50
      self.maxenergy = 200
      self.population = 1000
      self.maxpopulation = 5000
      self.sunsystem_id = pla_sunsystem_id
    end



  end

  def mention()
      self.sunsystem.mention()

  end

  #@param type Name der Produktionsstaette ("Eisenmine", "Haus", ...)
  def get_production(type)
    # TODO Calculate production
    b = self.buildings.where(name: type).production

    if( type == ore)
         a = self.user.get_ironproduction
         c = a * b
         return c

    end

    if( type == population)
      if(self.special = 2)
        a = SPEC_CONST * b

      else
        1
      end

    end



  end

  def get_building_factor_of(type)
    # TODO Calculate the factor of buildingspeed
    return 1
  end

  #Method which increases and updates all the resources a player has every ...Minute
  def update_resources
    if energy > 0 
      oremine = self.Buildings.find_by name: 'Oremine'
      ore_production = oremine.production
      energyneeded = oremine.eneryusage; 
      f = getProductionFactorOf(:ore)

      #Ore production
      if ore_production.integer? then
        ore_production = f * ore_production
        if (self.ore + ore_production) < self.maxore then
          self.ore += ore_production
        else
          self.ore = self.maxore
        end
        #Resque.enqueue_in(1.minute, ProduceResources, self.id)
      end


      city = Buildings.find_by name: 'City'
      city_population = city.production
      energyneeded += city.eneryusage;

      if city_population.integer? then
        #f???
        if (self.population + city_population) < self.maxpopulation then
          self.population += city_population
        else
          self.population = self.maxpopulation
        end
      end
      #Berechnung der Steuern der Einwohner. Start population sollte > 1000 sein
      taxes = (self.population / 100)
      headquarter = self.Buildings.find_by name: 'Headquarter'
      energyneeded += headquarter.eneryusage;
      headquarter_lev = headquarter.level

      earns = taxes * headquarter_lev

      owner = User.find_by id: self.user_id
      owner.money += earns
    end
=begin
  STROMKOSTEN DER RESTLICEHN GEBÄUDE BERECHNEN
=end

      #Berechnung der benoetigten Energie 
      powerplant = Buildings.find_by name: "Powerplant"
      power = powerplant.production
      #Reduziere um benötigte Gebauudenergy
      if energyneeded.integer?
        power -= energyneeded
      end  
      energy += power
      if energy.integer? then
        #f???
        if (self.energy + power) < self.maxenergy then
          self.energy += power
        else
          self.energy = self.maxenergy
        end
      end
    else  
    self.create_production_job

  end

  #grober entwurf
  def create_building_job(buildingtyp_id)
    Resque.enqueue(BuildBuildingjob, id_array(planet_id,buildingtyp_id))
  end

  def create_production_job()
    puts "Planeten ID #{self.id}"
    #Resque.enqueue(ProduceResources, self.id)
    Resque.enqueue_in(1.minute, ProduceResources, self.id)
  end

  def getDistance(other)
    if other.is_a?Planet then

      dist1 = self.Sunsystem.getDistance(other.Sunsystem)
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
        dist2 = ((self.z + other.z)^3)/((self.z - other.z)^2 + 1)
      end
      dist1 + dist2
    else
      -1
    end
  end

end

class Planet < ActiveRecord::Base


  belongs_to :sunsystem
  has_many :buildings
  has_many :fleets
  def get_production_factor_of(type)
    # TODO Calculate the factor of productionspeed
    return 1
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

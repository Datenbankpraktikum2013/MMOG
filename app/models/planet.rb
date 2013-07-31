class Planet < ActiveRecord::Base


  belongs_to :sunsystem
  has_many :buildings
  has_many :fleets
  def getProductionFactorOf(type)
    # TODO Calculate the factor of productionspeed
    return 1
  end

  def getBuildingFactorOf(type)
    # TODO Calculate the factor of buildingspeed
    return 1
  end

  #Method which increases and updates all the resources a player has every ...Minute
  def updateResources
=begin
    oremine = self.Buildings.find_by name: 'Oremine'
    ore_production = oremine.production

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
    taxes = city.production


    self.createProductionJob
=end
  end

  #grober entwurf
  def createBuildingJob(buildingtyp_id)
    Resque.enqueue(BuildBuildingjob, id_array(planet_id,buildingtyp_id))
  end

  def createProductionJob()
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

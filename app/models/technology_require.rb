class TechnologyRequire < ActiveRecord::Base

  belongs_to :tech, :class_name => "Technology"
  belongs_to :pre_tech, :class_name => "Technology"


  def self.technology_require? (user, tech)
    #TODO   chech the requirements for a specific technology -- return true if fulfilled

    #
    buildingresult = TechnologyRequire.where(:tech_id => tech).first.building_rank
      technoresult = TechnologyRequire.where(:tech_id => tech)

    if
      #TODO Abfrage des Technologie-Gebäude Rangs


    end
  end


end

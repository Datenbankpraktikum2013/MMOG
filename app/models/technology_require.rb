class TechnologyRequire < ActiveRecord::Base

  belongs_to :tech, :class_name => "Technology"
  belongs_to :pre_tech, :class_name => "Technology"


  def self.technology_require? (user, tech)
    #TODO   check the requirements for a specific technology -- return true if fulfilled

    okay = true

    result= TechnologyRequire.where(:tech_id => tech)

    result.each { |i|

      rank = UserTechnology.where(:user_id =>  user, :technology_id => i.pre_tech_id).first.rank

      if rank < i.pre_tech_rank
        okay=false
      end

      #TODO Abfrage des Technologie-Gebäude Rangs


    }

    okay

  end


end

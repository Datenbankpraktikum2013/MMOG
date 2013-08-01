class TechnologyRequire < ActiveRecord::Base

  belongs_to :tech, :class_name => "Technology"
  belongs_to :pre_tech, :class_name => "Technology"


  def self.technology_require? (user, tech)
    #TODO   check the requirements for a specific technology -- return true if fulfilled

    okay = true


    TechnologyRequire.where(:tech_id => tech).find_each do |i|


      if i.pre_tech_id != 0

      rank = UserTechnology.where(:user_id => user, :technology_id => i.pre_tech_id).first

        if rank.blank? then
          okay=false

        elsif rank.rank < i.pre_tech_rank && i.pre_tech_rank != 0

          puts 'Fehlende Voraussetzung', i.pre_tech_id, i.pre_tech_rank
          okay=false

        end

               #TODO Abfrage des Technologie-Gebäude Rangs

      end
    end


  #  }


   puts okay
    okay

  end


end

class TechnologyRequire < ActiveRecord::Base

  belongs_to :tech, :class_name => "Technology"
  belongs_to :pre_tech, :class_name => "Technology"


  def self.technology_require? (user, tech)
    #TODO   check the requirements for a specific technology -- return true if fulfilled

    okay = true

    unless max_rank?(user,tech)
      return okay = false
    end

    TechnologyRequire.where(:tech_id => tech).find_each do |i|


      if i.pre_tech_id != 0

      rank = UserTechnology.where(:user_id => user, :technology_id => i.pre_tech_id).first

        if rank.blank? then

          name = Technology.where(:id => i.pre_tech_id).first.name
          puts 'Technology_id: ' + i.pre_tech_id.to_s
          puts 'Technology_rank: has: '+ '0' + ' need: '+i.pre_tech_rank.to_s
          puts 'Name: '   + name.to_s
          okay=false

        elsif rank.rank < i.pre_tech_rank && i.pre_tech_rank != 0

          puts 'Fehlende Voraussetzung'
          name = Technology.where(:id => i.pre_tech_id).first.name
          puts 'Technology_id: ' + i.pre_tech_id.to_s
          puts 'Technology_rank: has:'+ rank.rank.to_s + ' need: '+i.pre_tech_rank.to_s
          puts 'Name: '   + name.to_s
          okay=false

        end

               #TODO Abfrage des Technologie-Gebäude Rangs

      end
    end


  #  }


   puts okay
    okay

  end

#Liefert false zurück sollte der max-rank erreicht sein
def self.max_rank? (user, tech)

  okay = true

  maxrank = Technology.where(:id => tech).first.maxrank
  result = UserTechnology.where(:user_id => user, :technology_id => tech ).first
  if !result.blank? then
    techrank = result.rank

    if  techrank == maxrank

      puts 'Maximal-rank'
      puts 'Technology_id: ' + tech.to_s
      puts 'Technology_rank: ' + techrank.to_s + ' Max-Rank: ' + maxrank.to_s
      puts 'Name: ' +  Technology.where(:id => tech).first.name.to_s

      okay=false

    end
  end
  okay
  end
end
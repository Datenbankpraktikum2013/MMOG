class TechnologyRequire < ActiveRecord::Base

  belongs_to :tech, :class_name => "Technology"
  belongs_to :pre_tech, :class_name => "Technology"


  def self.technology_require?(user, tech)

    # user = User.find(user_id)
    # tech= Technology.find(tech_id)

    unless building_rank_require?(user ,tech)
     return false
    end

    unless max_rank?(user,tech)
      return false
    end

    unless cost_required?(user, tech)
       return false
    end

    unless tech_require?(user, tech)
       return false
    end

    return true

  end



    # returns false wenn research_level nicht erreicht
    def self.building_rank_require?(user, tech)

      req_research_level = TechnologyRequire.where(:tech_id => tech).first.building_rank
      #req_research_level = tech.technology_requires.building_rank
      act_research_level =  User.find(user).get_researchlvl

       if  act_research_level < req_research_level

       puts 'Wrong research level'
       puts 'actual lvl: ' + act_research_level.to_s + ' needed level: ' + req_research_level.to_s

       return false
       end

       return true

     end

  #Liefert false zurück sollte der max-rank erreicht sein
  def self.max_rank?(user, tech)

    maxrank = Technology.find(tech).maxrank
    result = UserTechnology.where(:user_id => user, :technology_id => tech ).first
    if !result.blank? then
      techrank = result.rank

      if  techrank == maxrank

        puts 'Maximal-rank'
        puts 'Technology_id: ' + tech.to_s
        puts 'Technology_rank: ' + techrank.to_s + ' Max-Rank: ' + maxrank.to_s
        puts 'Name: ' +  Technology.where(:id => tech).first.name.to_s

        return false

      end
    end
    return true
  end

  def self.cost_required?(user, tech)

    costreq = Technology.find(tech).get_technology_cost(user)
    havecost= User.find(user).money


    if havecost < costreq
      puts 'not enough money'
      puts 'Your money: ' + havecost.to_s + ' needed money: ' + costreq.to_s

      return false
    end
    return true
  end

  #Gibt false zurück wenn Technologien nicht erfüllt
  def self.tech_require?(user, tech)

   okay = true
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

      end
    end
    return okay
  end
end
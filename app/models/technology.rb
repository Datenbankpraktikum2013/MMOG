class Technology < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ships
  has_many :user_technologies
  has_many :users, :through => :user_technologies

  has_many :technology_requires, :foreign_key => :tech_id
  #has_many :relations_from, :class_name => "TechnologyRequire", :foreign_key => "pre_tech_id"
  #has_many :relations_to, :class_name => "TechnologyRequire", :foreign_key => "tech_id"
  #has_many :linked_from, :through => :relations_to, :source => :pre_tech
  #has_many :linked_to, :through => :relations_from, :source => :tech


  #Updated die TechnolgieStufe des Users user
  def upgrade_technology(user)

    if technology_require?(user)

      #ziehe User Geld ab
      u = User.find(user)
      u.update_attribute(:money, u.money - self.get_technology_cost(user)

      Resque.enqueue_in(get_research_duration(user)), research_technology, user, id)



    end
  end

  def update_usertechnologies(user)
    result = user_technologies.where(:user_id => user).first
    new_rank = 1

    if !result.blank? then
      new_rank = result.rank + 1
      result.update_attribute(:rank, new_rank)
    else
      user_technologies.create(:rank => 1, :user_id => user)
    end

    #Update UserSettings
    self.update_usersettings(user, new_rank)
  end


  def update_usersettings(user, rank)

    record = UserSetting.find_by(:user_id => user)
    record.update_attribute(self.name, self.factor**rank)

  end


  def technology_require?(user)

    unless building_rank_require?(user)
      return false
    end

    unless max_rank?(user)
      return false
    end

    unless cost_required?(user)
      return false
    end

    unless tech_require?(user)
      return false
    end

    return true

  end

  def get_technology_cost(user)

    result = user_technologies.where(:user_id => user).first

    if !result.blank? then
      return  result.rank * cost

    else
      return cost
    end
  end

  def get_research_duration(user)

   result = user_technologies.where(:user_id => user).first

    if !result.blank? then
      return  result.rank * duration

    else
      return duration
   end
  end

  def building_rank_require?(user)

    req_research_lvl = technology_requires.first.building_rank
    act_research_lvl =  User.find(user).get_researchlvl

    if  act_research_lvl < req_research_lvl

      puts 'Wrong research level'
      puts 'actual lvl: ' + act_research_lvl.to_s + ' needed level: ' + req_research_lvl.to_s

      return false
    end

    return true
  end

  def max_rank?(user)

    result = user_technologies.where(:user_id => user).first

    if !result.blank? then

      if  result.rank == maxrank

        puts 'Maximal-rank'
        puts 'Technology_id: ' + tech.to_s
        puts 'Technology_rank: ' + techrank.to_s + ' Max-Rank: ' + maxrank.to_s
        puts 'Name: ' +  name.to_s

        return false

      end
    end
    return true
  end

  #Gibt false zurück wenn Technologien nicht erfüllt
  def tech_require?(user)

    okay = true
    technology_requires.find_each do |i|

      if i.pre_tech_id != 0

        rank = UserTechnology.where(:user_id => user, :technology_id => i.pre_tech_id).first
        rank = user_technologies.where(:user_id => user).first

        if rank.blank? then

          puts 'Technology_id: ' + i.pre_tech_id.to_s
          puts 'Technology_rank: has: '+ '0' + ' need: '+i.pre_tech_rank.to_s
          puts 'Name: '   + name.to_s
          okay=false

        elsif rank.rank < i.pre_tech_rank && i.pre_tech_rank != 0

          puts 'Fehlende Voraussetzung'
          puts 'Technology_id: ' + i.pre_tech_id.to_s
          puts 'Technology_rank: has:'+ rank.rank.to_s + ' need: '+i.pre_tech_rank.to_s
          puts 'Name: '   + name.to_s
          okay=false

        end

      end
    end
    return okay
  end


  def cost_required?(user)

    costreq = get_technology_cost(user)
    havecost= User.find(user).money

    if havecost < costreq
      puts 'not enough money'
      puts 'Your money: ' + havecost.to_s + ' needed money: ' + costreq.to_s

      return false
    end
    return true
  end


end

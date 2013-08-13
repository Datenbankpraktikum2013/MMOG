class Technology < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ships

  has_many :user_technologies
  has_many :users, :through => :user_technologies

  has_many :technology_requires, :foreign_key => :tech_id

  #@@cached_tech_require = {}
  #@@cached_technology_cost = {}
  #@@cached_research_duration = {}
  @@cached_technology_requirements = []

  def abort_technology u
    user =  User.find u
    user.user_setting.update_attribute :researching, 0
    user.update_attribute :money, (user.money + get_technology_cost(user)/2 )
    Resque.remove_delayed(ResearchTechnology, user.id, id)

  end

  #Updated die TechnolgieStufe des Users user
  def upgrade_technology u

    #Speichere User
    user = User.find u

    #Überprüfe, ob User alle Vorraussetzungen zum Upgraden erfüllt
    if technology_require? user


      #Forscht der User grade?
      if user.user_setting.researching != 0 then
        puts "Research in progress!"

      else
        duration = get_research_duration user



        #transaction do
          #Speichere aktuelle Forschung + Forschungsende
          user.user_setting.update_attribute :researching, id
          user.user_setting.update_attribute :finished_at, duration.second.from_now

          #ziehe Geld ab
          user.update_attribute :money, (user.money - get_technology_cost(user) )
          ####
          Resque.enqueue_in(duration.second, ResearchTechnology, user.id, id )
          #update_uservalues user
        #end
      end

    end
  end

  #Update Werte in UserSetting und UserTechnology
  def update_uservalues user

    user = User.find(user)

    puts "Update UserValues"
    #Suche vorhanden Eintrag
    record = user_technologies.where(:user => user).first
    #Wenn Eintrag nicht leer, erhöhe Rang um 1, sonst erzeuge Eintrag mit Rang 1
    if !record.blank? then
      new_rank = record.rank + 1
      record.update_attribute :rank, new_rank
    else
      new_rank = 1
      user_technologies.create(:rank => new_rank, :user => user)
    end
    #Speichere neuen Faktor ab
    user.user_setting.update_attribute name, factor**new_rank

    #Setze User-Forschung auf 0 -> Ende, lösche Cache
    #clear_cache user
    user.user_setting.update_attribute :researching, 0
    user.system_notify( 'Forschung', title, ' Technologie: '+title+' Stufe '+new_rank.to_s+' erfolgreich erforscht.')
  end

  #Prüft nacheinander alle Vorraussetzungen der Technology für einen user
  def technology_require? user

    #Korrekte ForschungsGebäudeStufe?
    unless building_rank_require? user
      return false
    end

    #Höchster Rang schon erreicht?
    if self.max_rank? user
      return false
    end

    #Hat sser genug Geld?
    unless cost_required? user
      return false
    end

    #Hat user die vorraussetzenden Forschungen erforscht?
    unless tech_require? user
      return false
    end

    #Alle Vorraussetzungen erfüllt -> true
    return true

  end

  #
  def get_research_duration(user)

    key = id.to_s + user.username.to_s
  #  if !@@cached_research_duration.has_key?( key )

      record = user_technologies.where(:user => user).first

      if !record.blank? then
        #@@cached_research_duration[key] =  (((1.3**record.rank) * duration) / user.user_setting.increased_research).round(1)
        return (((1.3**record.rank) * duration) / user.user_setting.increased_research).round(1)

      else
        #@@cached_research_duration[key] = (duration / user.user_setting.increased_research).round(1)
        return (duration / user.user_setting.increased_research).round(1)
      end
  #  end

    #@@cached_research_duration[key]
  end

  def building_rank_require?(user)

    req_research_lvl = technology_requires.first.building_rank
    act_research_lvl =  user.get_researchlvl

    if  act_research_lvl < req_research_lvl

      puts 'Wrong research level'
      puts 'actual lvl: ' + act_research_lvl.to_s + ' needed level: ' + req_research_lvl.to_s

      return false
    end

    return true
  end


  def max_rank?(user)


    record = user_technologies.where(:user => user).first

    if !record.blank?

      if  record.rank == maxrank


        puts 'Maximal-rank'
        puts 'Technology_id: ' + id.to_s
        puts 'record id:'    + record.to_s
        puts 'Technology_rank: ' + record.rank.to_s + ' Max-Rank: ' + maxrank.to_s
        puts 'Name: ' +  name.to_s

        return true

      end
    end
    return false
  end

  #Gibt false zurück wenn Technologien nicht erfüllt

  def tech_require?(user)
    key = id.to_s + user.username.to_s

  #  if !@@cached_tech_require.has_key?( key )

  #    @@cached_tech_require[key] = true
      okay = true;
      technology_requires.find_each do |i|

        if i.pre_tech_id != 0
          #u = User.find(user)
          rank = user.user_technologies.where(:technology_id => i.pre_tech_id).first
          #rank = user_technologies.where(:user_id => user).first

          if rank.blank? then

            puts 'Technology_id: ' + i.pre_tech_id.to_s
            puts 'Technology_rank: has: '+ '0' + ' need: '+i.pre_tech_rank.to_s
            puts 'Name: '   + name.to_s
            #@@cached_tech_require[key]=false
            okay = false

          elsif rank.rank < i.pre_tech_rank && i.pre_tech_rank != 0

            puts 'Fehlende Voraussetzung'
            puts 'Technology_id: ' + i.pre_tech_id.to_s
            puts 'Technology_rank: has:'+ rank.rank.to_s + ' need: '+i.pre_tech_rank.to_s
            puts 'Name: '   + name.to_s
            #@@cached_tech_require[key]=false
            okay = false


          end

        end
      end
    #end
    #@@cached_tech_require[key]
    okay
  end

  def cost_required?(user)

    costreq = get_technology_cost(user)
    havecost= user.money

    if havecost < costreq
      puts 'not enough money'
      puts 'Your money: ' + havecost.to_s + ' needed money: ' + costreq.to_s

      return false
    end
    return true
  end


  def get_technology_cost(user)

    key = id.to_s + user.username.to_s

    #if !@@cached_technology_cost.has_key?(key)
      record = user_technologies.where(:user_id => user).first

      if !record.blank? then

        #@@cached_technology_cost[key] = ((1.5**record.rank) * cost).round(0)
        return ((1.5**record.rank) * cost).round(0)
      else
        #@@cached_technology_cost[key] = cost.round(0)
        return cost.round(0)
      end
    #end

    #@@cached_technology_cost[key]

  end

  def get_technology_rank(user)

    record = user_technologies.where(:user_id => user).first

    if !record.blank? then
      return  record.rank

    else
      return 0.to_s
    end
  end

  def get_description
    description
  end


  def get_requirements

    if @@cached_technology_requirements[id].nil?
      @@cached_technology_requirements[id] = ''

      technology_requires.find_each do |tech|
        unless tech.pre_tech_id == 0
          @@cached_technology_requirements[id] << Technology.find(tech.pre_tech_id).title.to_s
          if tech.pre_tech_rank != 1
            @@cached_technology_requirements[id] << ': ' << tech.pre_tech_rank.to_s
          end
          @@cached_technology_requirements[id] << ', '
        end
      end

      len = @@cached_technology_requirements[id].length
      if len != 0
        @@cached_technology_requirements[id] = @@cached_technology_requirements[id][0..(len-3)]
      else
        @@cached_technology_requirements[id] = "Keine"
      end
    end
    @@cached_technology_requirements[id]

  end

  def clear_cache(user)
    puts "ClearCache"
    key = id.to_s + user.username.to_s
    @@cached_tech_require.delete(key)
    @@cached_technology_cost.delete(key)
    @@cached_research_duration.delete(key)
    #return nil

  end

  def test_view_technology_cost
    @@cached_technology_cost
  end

end

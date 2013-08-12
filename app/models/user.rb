class User < ActiveRecord::Base
  
  #callback on create
  after_create :set_initial_money
  after_create :claim_starplanet
  after_create :init_usersettings

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :recoverable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  #validations
  validate :is_username_set
  validate :is_username_taken, on: :create

  #relations
  has_one :user_setting, :dependent => :destroy
  has_many :user_technologies
  has_many :technologies, :through => :user_technologies

  has_many :fleets
  has_one :home_planet, :class_name => "Planet"
  has_many :planets

  has_many :receiving_reports
  has_many :reports, through: :receiving_reports
  has_and_belongs_to_many :sunsystems
  belongs_to :rank

  has_many :outgoing_requests, :class_name => 'Request', :foreign_key => 'sender_id'
  has_many :incoming_requests, :class_name => 'Request', :foreign_key => 'recipient_id'

  has_many :shipcounts
  belongs_to :alliance
  #receiving messages
  has_many :messages_user
  has_many :messages, :through => :messages_user, :source => :message, :select => "messages.*, messages_users.read AS read, messages_users.recipient_deleted as deleted"
  accepts_nested_attributes_for :messages_user
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  #relationships
  has_many :relationship
  has_many :friends, :through => :relationship, :source => :friend
  has_many :users, :through => :relationship, :source => :user
  has_many :reverse_relationships, foreign_key: "friend_id", class_name: "Relationship"

  @cache_visible_planets
  @cache_visible_sunsystems
  @cache_visible_galaxies

  def online?
    last_activity > 5.seconds.ago
  end

  #claim startplanet
  def claim_starplanet
    PlanetsHelper.claim_startplanet_for(self)
  end

  #check friendship
  def friends?(other_user)
    relationships.find_by_friend_id(other_user.id)
  end

  #create friendship  
  #send an invitation with status="pending"
  def make_friendship!(other_user)
    relationship.create!(friend_id: other_user.id)
    other_user.relationship.create!(friend_id: self.id)
    return true
  end

  #end friendship from both sides
  def end_friendship!(other_user)    
    relother=Relationship.where(user: other_user, friend: self).first
    relself=Relationship.where(user: self, friend: other_user).first
    if (relother==nil or relself==nil)
      return false
    else
      relother.destroy
      relself.destroy
      return true
    end
  end

  #accept invitation
  def accept_friendship(relationship)
    #not implemented      
  end

  def decline_friendship(relationship)
    
  end

  #change the pending status of the invitation
  def change_status(status)
    #not implemented    
  end    
  
  #init usersettings when user is created
  def init_usersettings
    UserSetting.create(:user => self)
  end

  #functions
  def is_username_set
  	if username.blank?
  		errors.add :username, "can't be blank"
  	end
  end

  def is_username_taken
  	if User.exists?(:username => username)
  		errors.add :username, "is already taken."
  	end
  end

  public
  def unread_messages
    count=0
    self.messages.each do |message|
        count+=1 unless message.read?
    end
    return count
  end

  #get user-settings affected by Research

  #affect ships
  def get_movement
    self.user_setting.increased_movement
  end

  def get_power
    self.user_setting.increased_current_userpower
  end

  def get_defense
    self.user_setting.increased_defense
  end

  def get_capacity
    self.user_setting.increased_capacity
  end

  def get_spypower
    self.user_setting.increased_spypower
  end

  #affect ressources
  def get_income
    self.user_setting.increased_income
  end

  def get_ironproduction
    self.user_setting.increased_ironproduction
  end

  def get_energy_efficiency
    self.user_setting.increased_energy_efficiency
  end

  #affect resear_duration
  def get_research
    self.user_setting.increased_research
  end

  #
  def get_big_house
    self.user_setting.big_house
  end

  #
  def has_hyperspace_technology?
    self.user_setting.hyperspace_technology
  end

  def has_large_cargo_ship?
    self.user_setting.large_cargo_ship
  end

  def has_large_defense_platform?
    self.user_setting.large_defense_platform
  end

  def has_destroyer?
    self.user_setting.destroyer
  end

  def has_cruiser?
    self.user_setting.cruiser
  end

  def has_deathstar?
    self.user_setting.deathstar
  end

  def get_researchlvl
    self.user_setting.researchlvl
  end

  #Planetengruppeneintrag
  #Methoden fuer die Forschungsgruppe am User bereitstellen
  def get_research_info
    PlanetsHelper.fetch_research_data(self)
  end

  def get_max_research_level
    PlanetsHelper.fetch_research_data(self)[0]
  end

  def get_research_level_count
    PlanetsHelper.fetch_research_data(self)[1]
  end

  def get_research_labs_count
    PlanetsHelper.fetch_research_data(self)[2]
  end


  def get_researching_tech

    array = []
    # 0 TechnologyName
    # 1 Stufe
    # 2 Startzeitpunkt
    # 3 Dauer
    # 4 Endzeitpunkt

    tech = user_setting.researching

    if tech != 0

      result = user_technologies.where(:technology_id => tech).first


      if result.blank? then
        rank = 1
      else
        rank = (result.rank) +1
      end
      time = user_setting.finished_at

      stunden = time.to_i/3600
      minuten = time.to_i/60 - stunden*60
      sekunden = time.to_i - minuten*60 - stunden*3600

      array[0] = Technology.find(tech).title.to_s
      array[1] = rank.to_s
      array[2] = user_setting.updated_at
      array[3] = Technology.find(tech).get_research_duration(self)
      array[4] = time


    end

    array

  end

  def visible_galaxies
    if !(GameSettings.get("caching?")) || @cache_visible_galaxies.nil? || @cache_visible_galaxies.empty?
      @cache_visible_galaxies = []
      suns = visible_sunsystems
      for s in suns
        @cache_visible_galaxies << s.galaxy
      end
    end
    return @cache_visible_galaxies
  end

  def visible_sunsystems
    if !(GameSettings.get("caching?")) || @cache_visible_sunsystems.nil? || @cache_visible_sunsystems.empty? then
      @cache_visible_sunsystems = []
      a = self.alliance
      ps = self.planets
      if a.nil? then
        @cache_visible_sunsystems = self.sunsystems
        ps.each do |p|
          @cache_visible_sunsystems << p.sunsystem
        end
      else
        ps.each do |p|
          @cache_visible_sunsystems << p.sunsystem
        end
        a_users = a.users
        a_users.each do |a_user|
        @cache_visible_sunsystems.concat a_user.sunsystems
        end
      end
    end
    return @cache_visible_sunsystems
  end

  def visible_planets
    if !(GameSettings.get("caching?")) || @cache_visible_planets.nil? || @cache_visible_planets.empty? then
      @cache_visible_planets = []
      for s in visible_sunsystems
        @cache_visible_planets.concat s.planets
      end
    end
    return @cache_visible_planets
  end

  def system_notify(prefix,subject,message)
    self.messages.create(:subject=>'['+prefix+']'+subject,:body=>message)
  end

  def add_score value
    update_attribute(:score, score + value)
  end

  private
    def set_initial_money(initial=GameSettings.get("INITIAL_BUDGET"))
      if self.money==0
        self.money=initial
        self.save
      end
    end


  ###########STATIC##############
  def self.system_notify_all(subject,message)
    User.all.each do |user|
      user.messages.create(:subject=>'[Systemweit]'+subject,:body=>message)
    end
  end

end

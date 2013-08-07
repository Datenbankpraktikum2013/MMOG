class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :recoverable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  #validations
  validate :is_username_set
  validate :is_username_taken, on: :create

  #relations
  has_one :user_setting, :dependent => :destroy
  belongs_to :rank
  has_many :user_technologies
  has_many :technologies, :through => :user_technologies

  has_many :fleets
  has_many :planets
  has_many :receiving_reports
  has_many :reports, through: :receiving_reports
  has_many :shipcounts
  belongs_to :alliance
  #receiving messages
  has_many :messages_user
  has_many :messages, :through => :messages_user, :source => :message, :select => "messages.*, messages_users.read AS read"
  accepts_nested_attributes_for :messages_user
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'

  #init usersettings when user is created
  after_create :init_usersettings
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

    string = ""
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

      string << 'Folgende Technologie wird erforscht: ' << Technology.find(tech).title.to_s << "\n"
      string << 'Erforsche Stufe :' << rank.to_s << "\n"
      string << 'Forschung beendet am ' << time.day.to_s << '.' << time.month.to_s << '.' << time.year.to_s
      string << ' um ' << time.hour.to_s << ':'
      if time.min < 10 then
        string << '0' << time.min.to_s
      else
        string << time.min.to_s
      end
      string << ":"
      if time.sec < 10 then
        string << '0' << time.sec.to_s
      else
        string << time.sec.to_s
      end

    end

    string

  end

end

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
  has_many :battlereports
  belongs_to :alliance
  has_and_belongs_to_many :messages

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

  #get user-settings affected by Research

  #affect ships
  def get_movement
    self.user_setting.increased_movement
  end

  def get_power
    self.user_setting.increased_power
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

  def has_large_defenseplattform?
    self.user_setting.large_defenseplattform
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
    self.user_setting.reseachlvl
  end

end

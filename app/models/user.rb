class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :recoverable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  #validations
  validate :is_username_set
  validate :is_username_taken

  #relations
  has_one :user_setting, :dependent => :destroy
  has_many :user_technologies
  has_many :fleets
  has_one :alliance

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
  def get_movement
    self.user_setting.increased_movement
  end

  def get_income
    self.user_setting.increased_income
  end

  def get_ironproduction
    self.user_setting.increased_ironproduction
  end

  def get_energy_efficiency
    self.user_setting.increased_energy_efficiency
  end

  def get_research
    self.user_setting.increased_research
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

  def get_big_house
    self.user_setting.big_house
  end

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

end

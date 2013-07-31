class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_one :user_setting, :dependent => :destroy
  has_many :user_technologies
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validate :is_nickname_set
  validate :is_nickname_taken

  def is_nickname_set
  	unless nickname.present?
  		errors.add :nickname, "can't be blank"
  	end
  end

  def is_nickname_taken
  	if User.where(:nickname => nickname)!=nil
  		errors.add :nickname, "is already taken."
  	end
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :technologies
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validate :is_nickname_set

  def is_nickname_set
  	unless nickname.present?
  		errors.add :nickname, "can't be blank"
  	end
  end
  def is_nickname_taken
  	if User.where(:nickname => nickname)?
  		errors.add :nickname, "is already taken."
  	end
end

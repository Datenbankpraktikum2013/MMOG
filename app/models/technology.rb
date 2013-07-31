class Technology < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ships
  has_many :user_technologies

  def upgrade_technology(user)

  end
end

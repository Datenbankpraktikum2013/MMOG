class Technology < ActiveRecord::Base
  has_many :user_technologies

  def upgrade_technology(user)

  end
end

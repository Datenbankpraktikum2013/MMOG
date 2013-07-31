class Technology < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ships
  has_many :user_technologies

  def upgrade_technology(user, tech)



    result = user_technologies.where(:user_id => user, :technology_id => tech).first

    if result!=nil then
      rank = result.rank
      result.update_attribute(:rank, rank+1)
    else
      create()
      user_technologies.create(:user_id => user, :technology_id => tech, :rank => 1)
    end
  end
end

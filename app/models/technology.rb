class Technology < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ships
  has_many :user_technologies

  #has_many :relations_to, :class_name => "TechnologyRequire", :foreign_key => "pre_tech_id"
  #has_many :relations_from, :class_name => "TechnologyRequire", :foreign_key => "tech_id"
  #has_many :linked_to, :trough => :relations_to, :source => :pre_tech
  #has_many :linked_from, :through => relations_from, :source => :tech


  def upgrade_technology(user, tech)

    if TechnologyRequire.technology_require?(user, tech)

      result = user_technologies.where(:user_id => user, :technology_id => tech).first
      if result!=nil then
        rank = result.rank
        result.update_attribute(:rank, rank+1)
      else
        UserTechnology.create(:user_id => user, :technology_id => tech, :rank => 1)
      end


    end
  end

end

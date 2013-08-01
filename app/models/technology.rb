class Technology < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ships
  has_many :user_technologies

  #has_many :relations_to, :class_name => "TechnologyRequire", :foreign_key => "pre_tech_id"
  #has_many :relations_from, :class_name => "TechnologyRequire", :foreign_key => "tech_id"
  #has_many :linked_to, :trough => :relations_to, :source => :pre_tech
  #has_many :linked_from, :through => relations_from, :source => :tech


  #Updated die TechnolgieStufe des Users user
  def upgrade_technology(user)

    if TechnologyRequire.technology_require?(user, self.id)

      result = user_technologies.where(:user_id => user).first

      if !result.blank? then
        result.update_attribute(:rank, result.rank+1)
      else
        user_technologies.create(:rank => 1, :user_id => user)
      end


    end
  end

end

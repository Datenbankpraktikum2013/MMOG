class TechnologyRequire < ActiveRecord::Base

  belongs_to :tech, :class_name => "Technology"
  belongs_to :pre_tech, :class_name => "Technology"


  def self.technology_require? (user, tech)
    #TODO   chech the requirements for a specific technology -- return true if fulfilled
    #get list of Requirements for tech
    requirement = TechnologyRequire.select(:pre_tech_id, :pre_tech_rank).where(:tech_id => tech)

    puts(requirement.select(:pre_tech_id).values.to_s)

    return false
  end


end

class TechnologyRequire < ActiveRecord::Base

  belongs_to :tech, :class_name => "Technology"
  belongs_to :pre_tech, :class_name => "Technology"


  def self.technology_require? (user, tech)
    #TODO   chech the requirements for a specific technology -- return true if fulfilled

    result = technology_requires.where(:technology_id => tech)
      

  end


end

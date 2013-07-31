class TechnologyRequire < ActiveRecord::Base

  belongs_to :tech, :class_name => "Technology"
  belongs_to :pre_tech, :class_name => "Technology"


  def technology_require? (techno, user)
    #TODO   chech the requirements for a specific technology -- return true if fulfilled

    #
      

  end


end

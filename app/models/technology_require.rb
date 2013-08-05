class TechnologyRequire < ActiveRecord::Base

  #belongs_to :tech, :class_name => "Technology"
  #belongs_to :pre_tech, :class_name => "Technology"
  belongs_to :technology

end
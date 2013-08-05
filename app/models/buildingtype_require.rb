class BuildingtypeRequire < ActiveRecord::Base
  belongs_to :buildingtype
  belongs_to :requirement, :class_name => "Buildingtype"

  def init_building_requirements

      BuildingtypeRequire.create()

  end

end

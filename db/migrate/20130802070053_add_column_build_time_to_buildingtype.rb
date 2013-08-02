class AddColumnBuildTimeToBuildingtype < ActiveRecord::Migration
  def change
    add_column :buildingtypes, :build_time, :integer
  end
end

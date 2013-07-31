class ConnectUniversePerRelation < ActiveRecord::Migration
  def change
    add_column :sunsystems, :galaxy_id, :integer
    add_column :planets, :sunsystem_id, :integer
    add_column :planets, :user_id, :integer
    add_column :buildings, :planet_id, :integer
    rename_column :buildings, :typeid, :buildingtype_id
  end
end

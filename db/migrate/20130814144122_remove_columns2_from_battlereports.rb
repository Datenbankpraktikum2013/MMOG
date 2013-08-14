class RemoveColumns2FromBattlereports < ActiveRecord::Migration
  def change
    remove_column :battlereports, :maxenergy, :integer
    remove_column :battlereports, :maxcrystal, :integer
    remove_column :battlereports, :maxore, :integer
    remove_column :battlereports, :maxpopulation, :integer
  end
end

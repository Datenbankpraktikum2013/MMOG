class AddColumnsToBattlereports < ActiveRecord::Migration
  def change
    add_column :battlereports, :maxore, :integer
    add_column :battlereports, :maxcrystal, :integer
    add_column :battlereports, :maxenergy, :integer
    add_column :battlereports, :maxpopulation, :integer
  end
end

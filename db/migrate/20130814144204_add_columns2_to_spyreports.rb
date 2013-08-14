class AddColumns2ToSpyreports < ActiveRecord::Migration
  def change
    add_column :spyreports, :maxenergy, :integer
    add_column :spyreports, :maxcrystal, :integer
    add_column :spyreports, :maxore, :integer
    add_column :spyreports, :maxpopulation, :integer
  end
end

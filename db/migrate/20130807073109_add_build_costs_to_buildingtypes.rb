class AddBuildCostsToBuildingtypes < ActiveRecord::Migration
  def change
    add_column :buildingtypes, :build_cost_ore, :integer, :default => 0
    add_column :buildingtypes, :build_cost_crystal, :integer, :default => 0
    add_column :buildingtypes, :build_cost_money, :integer, :default => 0
    add_column :buildingtypes, :build_cost_population, :integer, :default => 0
  end
end

class RemoveColumnsFromBattlereports < ActiveRecord::Migration
  def change
    remove_column :battlereports, :defender_planet_id, :integer
    remove_column :battlereports, :attacker_planet_id, :integer
    remove_column :battlereports, :fightdate, :datetime
    remove_column :battlereports, :defender_id, :integer
    remove_column :battlereports, :attacker_id, :integer
  end
end

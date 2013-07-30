class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.float :increased_income, :default => 1.0
      t.float :increased_ironproduction, :default => 1.0
      t.float :increased_energy_efficiency, :default => 1.0
      t.float :increased_movement, :default => 1.0
      t.float :big_house, :default => 1.0
      t.float :increased_research, :default => 1.0
      t.float :increased_power, :default => 1.0
      t.float :increased_defense, :default => 1.0
      t.float :increased_capacity, :default => 1.0
      t.boolean :hyperspace_technology, :default => 'false'
      t.boolean :large_cargo_ship, :default => 'false'
      t.boolean :large_defenseplattform, :default => 'false'
      t.boolean :destroyer, :default => 'false'
      t.boolean :cruiser, :default => 'false'
      t.boolean :deathstar, :default => 'false'

      t.timestamps
    end
  end
end

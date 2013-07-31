class CreateFleets < ActiveRecord::Migration
  def change
    create_table :fleets do |t|
      t.integer :credit
      t.integer :ressource_capacity
      t.integer :ore
      t.integer :crystal
      t.float :storage_factor
      t.float :velocity_factor
      t.integer :offense
      t.integer :defense
      t.references :user, index: true
      t.references :mission, index: true
      t.integer :departure_time
      t.integer :arrival_time
      t.integer :start_planet
      t.integer :target_planet

      t.timestamps
    end
  end
end

class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.integer :construction_time
      t.integer :offense
      t.integer :defense
      t.integer :crystal_cost
      t.integer :credit_cost
      t.integer :ore_cost
      t.string :name
      t.integer :velocity
      t.integer :crew_capacity
      t.integer :ressource_capasity
      t.integer :fuel_capacity
      t.integer :consumption

      t.timestamps
    end
  end
end

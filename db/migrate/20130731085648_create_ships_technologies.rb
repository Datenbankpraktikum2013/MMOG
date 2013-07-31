class CreateShipsTechnologies < ActiveRecord::Migration
  def change
    create_table :ships_technologies do |t|
      t.integer :ship_id
      t.integer :technology_id
    end
  end
end

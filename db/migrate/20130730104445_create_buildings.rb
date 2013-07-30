class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.integer :id
      t.integer :typeid
      t.datetime :letzteaktion

      t.timestamps
    end
  end
end

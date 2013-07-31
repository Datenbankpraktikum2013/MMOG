class CreateShipfleets < ActiveRecord::Migration
  def change
    create_table :shipfleets do |t|
      t.integer :ship_id
      t.integer :fleet_id
      t.integer :amount

      t.timestamps
    end
  end
end

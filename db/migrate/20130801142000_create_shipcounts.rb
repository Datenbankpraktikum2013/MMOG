class CreateShipcounts < ActiveRecord::Migration
  def change
    create_table :shipcounts do |t|
      t.integer :battlereport_id
      t.integer :ship_id
      t.integer :amount
      t.integer :shipowner_time_type

      t.timestamps
    end
  end
end

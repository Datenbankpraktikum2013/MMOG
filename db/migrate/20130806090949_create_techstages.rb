class CreateTechstages < ActiveRecord::Migration
  def change
    create_table :techstages do |t|
      t.integer :spyreport_id
      t.integer :technology_id
      t.integer :level

      t.timestamps
    end
  end
end

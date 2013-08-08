class CreateTravelreports < ActiveRecord::Migration
  def change
    create_table :travelreports do |t|
      t.integer :mode

      t.timestamps
    end
  end
end

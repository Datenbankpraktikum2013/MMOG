class CreateColonisationreports < ActiveRecord::Migration
  def change
    create_table :colonisationreports do |t|
      t.integer :mode

      t.timestamps
    end
  end
end

class CreateSpyreports < ActiveRecord::Migration
  def change
    create_table :spyreports do |t|
      t.integer :energy
      t.integer :space_cash
      t.integer :population
      t.integer :ore
      t.integer :crystall

      t.timestamps
    end
  end
end

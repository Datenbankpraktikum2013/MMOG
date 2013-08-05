class CreateTradereports < ActiveRecord::Migration
  def change
    create_table :tradereports do |t|
      t.integer :ore
      t.integer :crystal
      t.integer :space_cash

      t.timestamps
    end
  end
end

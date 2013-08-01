class CreateBattlereports < ActiveRecord::Migration
  def change
    create_table :battlereports do |t|
      t.integer :defender_planet_id
      t.integer :attacker_planet_id
      t.datetime :fightdate
      t.integer :stolen_ore
      t.integer :stolen_crystal
      t.integer :stolen_space_cash
      t.integer :defender_id
      t.integer :attacker_id
      t.integer :winner_id

      t.timestamps
    end
  end
end

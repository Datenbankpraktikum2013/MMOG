class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :reportable, index: true, polymorphic: true
      t.references :defender_planet, index: true
      t.references :attacker_planet, index: true
      t.datetime :fightdate
      t.references :defender, index: true
      t.references :attacker, index: true
      t.boolean :read, default: false

      t.timestamps
    end
  end
end

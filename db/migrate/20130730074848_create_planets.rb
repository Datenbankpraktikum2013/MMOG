class CreatePlanets < ActiveRecord::Migration
  def change
    create_table :planets do |t|
      t.integer :z
      t.string :name
      t.integer :spezialisierung
      t.double :groesse
      t.integer :eisenerz
      t.integer :maxeisenerz
      t.integer :kristalle
      t.integer :maxkristalle
      t.integer :energie
      t.integer :maxenergie
      t.integer :einwohner
      t.integer :maxeinwohner

      t.timestamps
    end
  end
end

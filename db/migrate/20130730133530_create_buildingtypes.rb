class CreateBuildingtypes < ActiveRecord::Migration
  def change
    create_table :buildingtypes do |t|
      t.string :name
      t.integer :stufe
      t.integer :produktion
      t.integer :energieverbrauch

      t.timestamps
    end
  end
end

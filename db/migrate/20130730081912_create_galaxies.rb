class CreateGalaxies < ActiveRecord::Migration
  def change
    create_table :galaxies do |t|
      t.integer :x
      t.string :name

      t.timestamps
    end
  end
end

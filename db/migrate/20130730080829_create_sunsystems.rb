class CreateSunsystems < ActiveRecord::Migration
  def change
    create_table :sunsystems do |t|
      t.integer :y
      t.string :name

      t.timestamps
    end
  end
end

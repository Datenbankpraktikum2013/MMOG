class CreateAlliances < ActiveRecord::Migration
  def change
    create_table :alliances do |t|
      t.string  :name
      t.text 	:description
      t.timestamps
    end
  end
end

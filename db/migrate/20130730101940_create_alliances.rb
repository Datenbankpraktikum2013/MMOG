class CreateAlliances < ActiveRecord::Migration
  def change
    create_table :alliances do |t|
      t.integer  :alliance_founder_id
      t.string   :name
      t.text 	 :description
      t.timestamps
    end
  end
end

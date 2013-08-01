class CreateAlliances < ActiveRecord::Migration
  def change
    create_table :alliances do |t|
      t.string   :name
      t.text 	 :description
      t.string	 :banner
      t.timestamps
    end
  end
end

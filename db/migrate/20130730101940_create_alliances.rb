class CreateAlliances < ActiveRecord::Migration
  def change
    create_table :alliances do |t|
      t.string   :name,		:null=>false
      t.text 	 :description
      t.string	 :banner	#not implemented yet
      t.integer	 :rank_id	#default rank
      t.timestamps
    end
  end
end

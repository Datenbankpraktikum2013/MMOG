class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :name,       :null => false
      t.boolean :can_kick,      :default => false
      t.boolean :can_massmail,  :default => false
      t.boolean :can_edit_ranks,:default => false
      t.boolean :can_invite,    :default => false
      t.boolean :is_founder,    :default => false
      t.boolean :can_disband,   :default => false 
      t.boolean :standard,      :default => false
      t.boolean :can_change_description,  :default => false
      t.timestamps
    end
  end
end

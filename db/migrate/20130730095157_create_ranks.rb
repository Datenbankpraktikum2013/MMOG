class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :name,       :null => false
      t.boolean :can_kick,      :default => false
      t.boolean :can_massmail,  :default => false
      t.boolean :can_edit,      :default => false
      t.boolean :can_invite,    :default => false
      t.boolean :can_disband,   :default => false
      t.integer :alliance_id
      t.timestamps
    end
  end
end

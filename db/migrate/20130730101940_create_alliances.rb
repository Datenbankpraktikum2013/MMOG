class CreateAlliances < ActiveRecord::Migration
  def change
    create_table :alliances do |t|
      t.string :name
      t.integer :default_rank, :default => null

      t.timestamps
    end
  end
end

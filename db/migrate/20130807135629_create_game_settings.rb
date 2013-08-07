class CreateGameSettings < ActiveRecord::Migration
  def change
    create_table :game_settings, :id => false do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end

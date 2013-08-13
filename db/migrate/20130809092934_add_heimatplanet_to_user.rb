class AddHeimatplanetToUser < ActiveRecord::Migration
  def change
    add_column :users, :home_planet_id, :integer, :default => 0
  end
end

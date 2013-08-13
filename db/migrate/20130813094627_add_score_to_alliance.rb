class AddScoreToAlliance < ActiveRecord::Migration
  def change
    add_column :alliances, :score, :integer, :default=>0
  end
end

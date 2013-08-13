class AddsColumnScoreToTechnology < ActiveRecord::Migration
  def change
    add_column :technologies, :score, :integer, :default => 5
  end
end

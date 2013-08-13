class ChangeUnderConstructionInPlanets < ActiveRecord::Migration

  def self.up
    change_column :planets, :under_construction, :integer, :default => 0
  end

  def self.down
    change_column :planets, :under_construction, :boolean, :default => false
  end

end

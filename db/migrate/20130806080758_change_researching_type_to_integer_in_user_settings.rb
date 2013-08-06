class ChangeResearchingTypeToIntegerInUserSettings < ActiveRecord::Migration
  def change
    change_column :user_settings, :researching, :integer, :default => 0
  end
end

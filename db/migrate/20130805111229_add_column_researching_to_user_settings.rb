class AddColumnResearchingToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :researching, :boolean, :default => false
    add_column :user_settings, :finished_at, :datetime
  end
end

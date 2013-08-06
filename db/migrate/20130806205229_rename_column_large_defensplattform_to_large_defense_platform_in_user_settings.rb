class RenameColumnLargeDefensplattformToLargeDefensePlatformInUserSettings < ActiveRecord::Migration
  def change
    rename_column :user_settings, :large_defenseplattform, :large_defense_platform
  end
end

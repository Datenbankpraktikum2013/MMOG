class AddDefaultForReseachlvlInUserSettings < ActiveRecord::Migration
  def change
    change_column_default :user_settings, :reseachlvl, :default => 0
  end
end

class AddDefaultForReseachlvlInUserSettings < ActiveRecord::Migration
  def change
    change_column_default :user_settings, :reseachlvl, 0
  end
end

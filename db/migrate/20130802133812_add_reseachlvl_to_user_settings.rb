class AddReseachlvlToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :reseachlvl, :integer
  end
end

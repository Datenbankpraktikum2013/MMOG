class RenameColumnResearchLvlInUserSettings < ActiveRecord::Migration
  def change
    rename_column :user_settings, :reseachlvl, :researchlvl
    change_column_default :user_settings, :researchlvl, 1
  end
end

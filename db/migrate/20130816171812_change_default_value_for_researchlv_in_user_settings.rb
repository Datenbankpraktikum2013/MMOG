class ChangeDefaultValueForResearchlvInUserSettings < ActiveRecord::Migration
  def change
    change_column_default :user_settings, :researchlvl, 0
  end
end

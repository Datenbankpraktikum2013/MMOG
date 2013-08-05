class FixDefaultValueInUserSettings < ActiveRecord::Migration
  def change
    change_column_default :user_settings, :researchlvl, 1
  end
end

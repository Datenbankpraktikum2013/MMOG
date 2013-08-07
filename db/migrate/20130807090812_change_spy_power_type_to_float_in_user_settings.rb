class ChangeSpyPowerTypeToFloatInUserSettings < ActiveRecord::Migration
  def change
    change_column :user_settings, :increased_spypower, :float, :default => 1.0
  end
end

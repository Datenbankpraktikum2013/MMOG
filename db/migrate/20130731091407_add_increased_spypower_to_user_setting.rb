class AddIncreasedSpypowerToUserSetting < ActiveRecord::Migration
  def change
    add_column :user_settings, :increased_spypower, :integer, default: "1"
  end
end

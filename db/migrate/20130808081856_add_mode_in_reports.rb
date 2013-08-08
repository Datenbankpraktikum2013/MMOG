class AddModeInReports < ActiveRecord::Migration
  def change
  	add_column :battlereports, :mode, :integer
  	add_column :tradereports, :mode, :integer
  end
end

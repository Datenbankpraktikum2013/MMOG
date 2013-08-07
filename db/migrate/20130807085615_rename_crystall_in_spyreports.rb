class RenameCrystallInSpyreports < ActiveRecord::Migration
  def change
	rename_column :spyreports, :crystall, :crystal
  end
end

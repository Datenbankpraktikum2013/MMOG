class RemoveReadFromBattlereports < ActiveRecord::Migration
  def change
    remove_column :battlereports, :read, :boolean
  end
end

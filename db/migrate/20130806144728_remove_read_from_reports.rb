class RemoveReadFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :read, :boolean
  end
end

class RemoveDefenderidFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :defender_id, :integer
  end
end

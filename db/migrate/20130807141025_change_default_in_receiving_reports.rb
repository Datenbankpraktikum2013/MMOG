class ChangeDefaultInReceivingReports < ActiveRecord::Migration
  def change
    change_column :receiving_reports, :read, :boolean, default: false
  end
end

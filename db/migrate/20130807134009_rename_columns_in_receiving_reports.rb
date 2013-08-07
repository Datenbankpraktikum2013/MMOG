class RenameColumnsInReceivingReports < ActiveRecord::Migration
  def change
    rename_column :receiving_reports, :user_id_id, :user_id
    rename_column :receiving_reports, :report_id_id, :report_id
  end
end

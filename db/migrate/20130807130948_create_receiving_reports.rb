class CreateReceivingReports < ActiveRecord::Migration
  def change
    create_table :receiving_reports do |t|
      t.references :report_id, index: true
      t.references :user_id, index: true
      t.boolean :read, default: true

      t.timestamps
    end
  end
end

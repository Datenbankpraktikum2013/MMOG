class DropTableReportsUsers < ActiveRecord::Migration
  def up
    drop_table :reports_users
  end
  def down
    create_table :reports_users do |t|
      t.integer :user_id
      t.integer :report_id
    end
  end
end

class CreateReportsUsers < ActiveRecord::Migration
  def change
    create_table :reports_users do |t|
      t.integer :user_id
      t.integer :report_id
    end
  end
end

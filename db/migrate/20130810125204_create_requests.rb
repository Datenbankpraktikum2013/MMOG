class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :requestvalue
      t.string :action
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end

class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text 	:body
      t.integer :sender_id
      t.string  :subject
	  t.boolean	 :sender_deleted, default: false
      t.timestamps
    end
  end
end

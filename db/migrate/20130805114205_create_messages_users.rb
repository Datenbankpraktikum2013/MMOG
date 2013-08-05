class CreateMessagesUsers < ActiveRecord::Migration
  def change
    create_table :messages_users, :id=>false do |t|
      t.boolean :seen
      t.references :recipient 
      t.references :message
  	end
  end
end
class CreateMessagesUsers < ActiveRecord::Migration
  def change
    create_table :messages_users do |t|
    	t.belongs_to :user
     	t.belongs_to :message
     	t.boolean	 :read, default: false
    end
  end
end

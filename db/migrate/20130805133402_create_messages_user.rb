class CreateMessagesUser < ActiveRecord::Migration
  def change
    create_table :messages_user do |t|
    	t.belongs_to :user
     	t.belongs_to :message
     	t.boolean	 :read, default: false
    end
  end
end

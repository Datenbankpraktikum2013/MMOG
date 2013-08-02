class CreateUsersMessages < ActiveRecord::Migration
  def change
    create_table :users_messages, id: false do |t|
    	t.references :user,    null: false
    	t.references :message, null: false
    	t.boolean    :read,    :default => false
    end
  end
end

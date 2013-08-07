class CreateSunsystemsUsers < ActiveRecord::Migration
  def change
    create_table :sunsystems_users, :id => false do |t|
      t.integer :sunsystem_id
      t.integer :user_id
    end
  end
end

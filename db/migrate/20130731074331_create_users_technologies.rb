class CreateUsersTechnologies < ActiveRecord::Migration
  def change
    create_table :users_technologies, :id => false do |t|
      t.integer :user_id
      t.integer :technology_id
      t.integer :rank
    end
  end
end

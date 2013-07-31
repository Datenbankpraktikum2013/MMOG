class CreateUserTechnologies < ActiveRecord::Migration
  def change
    create_table :user_technologies do |t|
      t.integer :rank
      t.integer :user_id
      t.integer :technology_id

      t.timestamps
    end
  end
end

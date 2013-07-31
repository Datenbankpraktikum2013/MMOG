class DeleteTableUsersTechnologies < ActiveRecord::Migration
  def up
    drop_table :users_technologies
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

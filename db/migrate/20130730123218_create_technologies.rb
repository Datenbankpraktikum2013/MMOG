class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :name
      t.float :factor
      t.float :cost

      t.timestamps
    end
  end
end

class CreateTechnologyRequires < ActiveRecord::Migration
  def change
    create_table :technology_requires do |t|
      t.integer :tech_id
      t.integer :building_rank
      t.integer :pre_tech_id
      t.integer :pre_tech_rank
    end
  end
end

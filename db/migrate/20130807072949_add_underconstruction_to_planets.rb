class AddUnderconstructionToPlanets < ActiveRecord::Migration
  def change
    add_column :planets, :under_construction, :boolean
  end
end

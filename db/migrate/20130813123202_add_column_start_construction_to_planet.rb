class AddColumnStartConstructionToPlanet < ActiveRecord::Migration
  def change
    add_column :planets, :start_construction_at, :datetime
  end
end

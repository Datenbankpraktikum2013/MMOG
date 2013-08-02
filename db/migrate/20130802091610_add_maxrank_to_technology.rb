class AddMaxrankToTechnology < ActiveRecord::Migration
  def change
    add_column :technologies, :maxrank, :integer
  end
end

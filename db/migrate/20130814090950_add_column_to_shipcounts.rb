class AddColumnToShipcounts < ActiveRecord::Migration
  def change
    add_column :shipcounts, :amount_after, :integer
  end
end

class AddColumnUseridToShipcounts < ActiveRecord::Migration
  def change
    add_column :shipcounts, :user_id, :integer
  end
end

class AddAllianceIdToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :alliance_id, :integer
  end
end

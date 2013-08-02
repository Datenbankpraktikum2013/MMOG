class AddReadToBattlereports < ActiveRecord::Migration
  def change
    add_column :battlereports, :read, :boolean, default: false
  end
end

class AddColumnsToSpyreport < ActiveRecord::Migration
  def change
    add_column :spyreports, :spylevel, :integer
    add_column :spyreports, :mode, :integer
  end
end

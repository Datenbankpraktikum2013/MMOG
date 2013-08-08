class AddColumnToReport < ActiveRecord::Migration
  def change
    add_reference :reports, :defender, index: true
  end
end

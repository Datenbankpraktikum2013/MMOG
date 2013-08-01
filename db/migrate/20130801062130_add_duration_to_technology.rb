class AddDurationToTechnology < ActiveRecord::Migration
  def change
    add_column :technologies, :duration, :integer
  end
end

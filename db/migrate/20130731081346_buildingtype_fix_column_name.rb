class BuildingtypeFixColumnName < ActiveRecord::Migration
  def change
    rename_column :buildingtypes, :produktion, :production
    rename_column :buildingtypes, :stufe, :level
    rename_column :buildingtypes, :energieverbrauch, :energyusage
  end
end

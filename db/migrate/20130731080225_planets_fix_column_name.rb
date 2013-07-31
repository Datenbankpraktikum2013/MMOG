class PlanetsFixColumnName < ActiveRecord::Migration

  def change
    rename_column :planets, :eisenerz, :ore
    rename_column :planets, :maxeisenerz, :maxore
    rename_column :planets, :kristalle, :crystal
    rename_column :planets, :maxkristalle, :maxcrystal
    rename_column :planets, :einwohner, :population
    rename_column :planets, :maxeinwohner, :maxpopulation
    rename_column :planets, :energie, :energy
    rename_column :planets, :maxenergie, :maxenergy
    rename_column :planets, :spezialisierung, :special
    rename_column :planets, :groesse, :size
  end

end

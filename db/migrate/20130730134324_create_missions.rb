class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :info_text

      t.timestamps
    end
  end
end

class AddColumnsDescriptionTitleToTechnology < ActiveRecord::Migration
  def change
    add_column :technologies, :description, :string
    add_column :technologies, :title, :string
  end
end

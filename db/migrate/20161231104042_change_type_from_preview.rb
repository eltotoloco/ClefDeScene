class ChangeTypeFromPreview < ActiveRecord::Migration[5.0]
  def change
  	change_column :previews, :type, :string, :null => false

  end
end

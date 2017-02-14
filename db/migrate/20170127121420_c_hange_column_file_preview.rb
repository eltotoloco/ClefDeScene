class CHangeColumnFilePreview < ActiveRecord::Migration[5.0]
  def change
  	  	change_column :previews, :file,  'json USING file::json'
  end
end

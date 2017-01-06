class AddAnnonceTokenToPreview < ActiveRecord::Migration[5.0]
  def change
  			add_column :previews, :annonce_token, :string

  end
end

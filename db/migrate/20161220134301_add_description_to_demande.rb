class AddDescriptionToDemande < ActiveRecord::Migration[5.0]
  def change
    add_column :demandes, :description, :text
  end
end

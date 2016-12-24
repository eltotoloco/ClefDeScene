class AddAnnonceRefToDemandes < ActiveRecord::Migration[5.0]
  def change
    add_reference :demandes, :annonce, foreign_key: true
  end
end

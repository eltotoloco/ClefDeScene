class AddAnnonceRefToMembres < ActiveRecord::Migration[5.0]
  def change
    add_reference :membres, :annonce, foreign_key: true
  end
end

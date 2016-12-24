class AddAnnonceRefToUtilises < ActiveRecord::Migration[5.0]
  def change
    add_reference :utilises, :annonce, foreign_key: true
  end
end

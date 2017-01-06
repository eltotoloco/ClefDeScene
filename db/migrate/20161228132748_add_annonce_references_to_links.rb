class AddAnnonceReferencesToLinks < ActiveRecord::Migration[5.0]
  def change
  	  	    add_reference :links, :annonce, foreign_key: true

  end
end

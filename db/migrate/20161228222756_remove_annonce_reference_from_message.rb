class RemoveAnnonceReferenceFromMessage < ActiveRecord::Migration[5.0]
  def change
  	    remove_reference :messages, :annonce, foreign_key: true

  end
end

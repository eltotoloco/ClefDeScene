class AddDemandeReferenceToMessage < ActiveRecord::Migration[5.0]
  def change
  	  	  	    add_reference :messages, :demande, foreign_key: true

  end
end

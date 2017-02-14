class AddUserReferencesToProfil < ActiveRecord::Migration[5.0]
  def change
  	  	  	    add_reference :profils, :user, foreign_key: true

  end
end

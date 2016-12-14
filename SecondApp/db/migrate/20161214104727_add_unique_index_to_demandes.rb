class AddUniqueIndexToDemandes < ActiveRecord::Migration[5.0]
  def change
  	    add_index :demandes, [:groupe_id, :start_date], unique: true

  end
end

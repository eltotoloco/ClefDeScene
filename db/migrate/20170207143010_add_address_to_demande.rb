class AddAddressToDemande < ActiveRecord::Migration[5.0]
  def change
  	    add_column :demandes, :address, :string
  end
end

class AddTokenToDemande < ActiveRecord::Migration[5.0]
  def change
  	    add_column :demandes, :token, :string

  end
end

class AddDemandeReferenceToPayment < ActiveRecord::Migration[5.0]
  def change
  			add_reference :payments, :demande, foreign_key: true

  end
end

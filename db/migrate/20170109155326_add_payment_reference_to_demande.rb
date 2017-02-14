class AddPaymentReferenceToDemande < ActiveRecord::Migration[5.0]
	def change
		add_reference :demandes, :payment, foreign_key: true

	end
end

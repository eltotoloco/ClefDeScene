class AddReferenceToUserToDemande < ActiveRecord::Migration[5.0]
	def change
		add_foreign_key :demandes, :users, column: :to_user_id, primary_key: :id


	end
end

class ChangeFromAndToFromDemande < ActiveRecord::Migration[5.0]
	def change

		rename_column :demandes, :from, :from_user_id
		rename_column :demandes, :to, :to_user_id


	end
end

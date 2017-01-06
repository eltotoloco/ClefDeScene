class AddFromToAboutToDemande < ActiveRecord::Migration[5.0]
	def change
		rename_column :demandes, :user_id, :from
		add_column :demandes, :to, :integer
	end
end

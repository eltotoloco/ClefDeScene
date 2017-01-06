class AddTokenToAnnonce < ActiveRecord::Migration[5.0]
	def change
		add_column :annonces, :token, :string

	end
end

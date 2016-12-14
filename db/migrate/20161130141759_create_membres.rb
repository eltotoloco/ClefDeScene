class CreateMembres < ActiveRecord::Migration[5.0]
	def change
		create_table :membres do |t|
			t.string :nom
			t.string :instrument
			t.references :groupe, foreign_key: true
		end
	end
end

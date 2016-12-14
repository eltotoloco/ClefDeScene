class CreateGroupes < ActiveRecord::Migration[5.0]
	def change
		create_table :groupes do |t|
			t.string :name, null: false, default: ""
			t.references :user, foreign_key: true
			t.string :genre
			t.date :date_de_creation
			t.text :description
			t.timestamps
		end
	end
end

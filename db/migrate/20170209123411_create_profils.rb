class CreateProfils < ActiveRecord::Migration[5.0]
  def change
    create_table :profils do |t|
      t.string :last_name
      t.string :first_name
      t.date :date_of_birth
      t.string :avatar
      t.text :bio
      t.string :phone_number

      t.timestamps
    end
  end
end

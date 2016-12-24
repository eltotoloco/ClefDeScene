class CreateEstablishments < ActiveRecord::Migration[5.0]
  def change
    create_table :establishments do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :address
      t.json :pictures
      t.string :phone_number

      t.timestamps
    end
  end
end

class CreateDemandes < ActiveRecord::Migration[5.0]
  def change
    create_table :demandes do |t|
      t.references :user, foreign_key: true
      t.references :groupe, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :prix
      t.integer :statut

      t.timestamps
    end
  end
end

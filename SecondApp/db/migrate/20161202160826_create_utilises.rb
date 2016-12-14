class CreateUtilises < ActiveRecord::Migration[5.0]
  def change
    create_table :utilises do |t|
      t.references :groupe, foreign_key: true
      t.references :materiel, foreign_key: true
      t.integer :quantite
    end
  end
end

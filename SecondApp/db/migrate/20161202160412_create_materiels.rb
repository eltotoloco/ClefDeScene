class CreateMateriels < ActiveRecord::Migration[5.0]
  def change
    create_table :materiels do |t|
      t.string :libelle
    end
  end
end

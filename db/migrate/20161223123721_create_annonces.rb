class CreateAnnonces < ActiveRecord::Migration[5.0]
  def change
    create_table :annonces do |t|
      t.string :name
      t.string :avatar
      t.date :experience
      t.text :description
      t.string :type
      t.string :style

      t.timestamps
    end
  end
end

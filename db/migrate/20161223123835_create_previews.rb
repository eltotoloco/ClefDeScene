class CreatePreviews < ActiveRecord::Migration[5.0]
  def change
    create_table :previews do |t|
      t.integer :type
      t.string :file
      t.references :annonce, foreign_key: true

      t.timestamps
    end
  end
end

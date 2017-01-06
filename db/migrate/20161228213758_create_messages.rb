class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :from
      t.integer :to
      t.references :annonce, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end

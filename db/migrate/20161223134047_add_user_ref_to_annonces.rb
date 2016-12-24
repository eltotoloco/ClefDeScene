class AddUserRefToAnnonces < ActiveRecord::Migration[5.0]
  def change
    add_reference :annonces, :user, foreign_key: true
  end
end

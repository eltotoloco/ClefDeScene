class RemoveGroupeRefToMembres < ActiveRecord::Migration[5.0]
  def change
    remove_reference :membres, :groupe, foreign_key: true
  end
end

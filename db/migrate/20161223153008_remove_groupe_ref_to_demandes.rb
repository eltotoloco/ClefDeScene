class RemoveGroupeRefToDemandes < ActiveRecord::Migration[5.0]
  def change
    remove_reference :demandes, :groupe, foreign_key: true
  end
end

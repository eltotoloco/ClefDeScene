class RemoveGroupeRefToUtilises < ActiveRecord::Migration[5.0]
  def change
    remove_reference :utilises, :groupe, foreign_key: true
  end
end

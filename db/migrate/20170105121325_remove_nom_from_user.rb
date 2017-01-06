class RemoveNomFromUser < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :nom
  end
end

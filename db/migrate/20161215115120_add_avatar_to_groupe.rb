class AddAvatarToGroupe < ActiveRecord::Migration[5.0]
  def change
    add_column :groupes, :avatar, :string
  end
end

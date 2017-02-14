json.extract! profil, :id, :last_name, :first_name, :date_of_birth, :avatar, :bio, :phone_number, :created_at, :updated_at
json.url profil_url(profil, format: :json)
json.extract! demande, :id, :user_id, :groupe_id, :start_date, :end_date, :prix, :statut, :created_at, :updated_at
json.url demande_url(demande, format: :json)
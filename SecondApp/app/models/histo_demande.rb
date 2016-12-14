class HistoDemande < ApplicationRecord
  belongs_to :demande
  belongs_to :user
  belongs_to :groupe
end

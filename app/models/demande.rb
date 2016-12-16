class Demande < ApplicationRecord
	validates_with DemandeValidator

	belongs_to :user
	belongs_to :groupe
	enum statut: [:en_attente, :confirmee, :refusee, :terminee]
	after_initialize :set_default_statut, :if => :new_record?
	validates :start_date, presence: true
	validates :user_id, presence: true
	validates :groupe_id, presence: true

	scope :by_groupe, -> (groupe_id) {where groupe: groupe_id}
	scope :by_user, -> (user_id) {where user: user_id}
	scope :statut, -> (statut) {where statut: statut}

	def set_default_statut
		self.statut ||= :en_attente
	end
end

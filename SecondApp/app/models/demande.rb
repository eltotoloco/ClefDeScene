class Demande < ApplicationRecord
	belongs_to :user
	belongs_to :groupe
	enum statut: [:en_attente, :confirmee, :refusee, :terminee]
	after_initialize :set_default_statut, :if => :new_record?
	validates_uniqueness_of :groupe_id, scope: [:start_date]
	def set_default_statut
		self.statut ||= :en_attente
	end
end

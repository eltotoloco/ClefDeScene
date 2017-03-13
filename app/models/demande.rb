class Demande < ApplicationRecord
	belongs_to :from_user,    class_name: "User", foreign_key: "from_user_id"
	belongs_to :to_user, class_name: "User", foreign_key: "to_user_id"
	belongs_to :annonce
	enum statut: [:en_attente, :confirmee, :refusee, :terminee]
	after_initialize :set_default_statut, :if => :new_record?

	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :from_user_id, presence: true
	validates :to_user_id, presence: true
	validates :annonce_id, presence: true
	#validates :token, presence: true
	validates :address, presence: true
	validates :description, presence: true

	#validates :payment,  presence: true
	has_many :messages, dependent: :delete_all
	scope :by_annonce, -> (annonce_id) {where annonce: annonce_id}
	scope :from_user, -> (user_id) {where from_user_id: user_id}
	scope :to_user, -> (user_id) {where to_user_id: user_id}
	scope :statut, -> (statut) {where statut: statut}

	has_one :payment
	accepts_nested_attributes_for :payment, :allow_destroy => true, reject_if: ->(attributes){ attributes['first_name'].blank? }


	def set_default_statut
		self.statut ||= :en_attente
	end


	def unReadMessages
		value = 0
		self.messages.each do |message|
			if !message.read
				value = value +1
			end
		end
		value
	end
end

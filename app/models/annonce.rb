class Annonce < ApplicationRecord

	include Filterable

  mount_uploader :avatar, AvatarUploader

  belongs_to :user
  has_many :membres, :inverse_of => :annonce, dependent: :delete_all
  has_many :utilises, :inverse_of => :annonce, dependent: :delete_all
  has_many :demandes, :inverse_of => :annonce, dependent: :delete_all
  has_many :previews, :inverse_of => :annonce, dependent: :delete_all
  has_many :links, :inverse_of => :annonce, dependent: :delete_all
  has_many :availabilities, dependent: :delete_all

    #scopes
    scope :groups, -> { where(type: 'Group') } 
    scope :photographers, -> { where(type: 'Photographer') }
    scope :by_type, ->(type) { where(type: type)}
    scope :by_name, -> (name) {where("name like ?", "%#{name}%")}
    scope :by_style, ->(style) {where("style = ?",style)}
    scope :by_id, ->(id) {find(id)}
    scope :booked, -> (date) {left_outer_joins(:demandes).where('? BETWEEN demandes.start_date and demandes.end_date', date)}
    #scope :date, ->(date) {left_outer_joins(:demandes).where('? NOT BETWEEN demandes.start_date and demandes.end_date', date)}
    scope :not_booked, ->(date) {where(' id NOT IN (?)', booked(date).select("annonces.id"))}
    scope :available, ->(date) {where()}

  #nested attr
  accepts_nested_attributes_for :membres, :allow_destroy => true, reject_if: ->(attributes){ attributes['nom'].blank? && attributes['instrument'].blank? }
  accepts_nested_attributes_for :utilises, :allow_destroy => true, reject_if: ->(attributes){ attributes['materiel'].blank? }
  accepts_nested_attributes_for :previews, :allow_destroy => true, reject_if: ->(attributes){ attributes['file'].blank? }
  accepts_nested_attributes_for :links, :allow_destroy => true, reject_if: ->(attributes){ attributes['url'].blank? }
  accepts_nested_attributes_for :availabilities, :allow_destroy => true, reject_if: ->(attributes){ attributes['start_date'].blank? }
  
  #validation
  validates :type, presence: true
  validates :user, presence: true
  validates :level, presence: true
  validates :price, presence: true
  validates :name, uniqueness: { case_sensitive: false,  scope: :type }, presence: true 
  validates :experience, presence: true
  validates_associated :previews
 # validates :avatar, presence: true
 validates_integrity_of  :avatar
 validates_processing_of :avatar

 enum level: [:amateur, :semi_pro, :pro]


def self.generate_token
  token = loop do
    random_token = SecureRandom.urlsafe_base64
    break random_token unless Annonce.where(token: random_token).exists?
  end
end

def self.types
 %w(Group Photographer)
end

def self.select_options
 descendants.map{ |c| c.to_s }.sort
end

end

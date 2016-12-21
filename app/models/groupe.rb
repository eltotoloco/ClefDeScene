class Groupe < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Filterable

  mount_uploader :avatar, AvatarUploader

  belongs_to :user
  has_many :membres, :inverse_of => :groupe, dependent: :destroy
  has_many :utilises, :inverse_of => :groupe, dependent: :destroy
  has_many :demandes, :inverse_of => :groupe, dependent: :destroy

    #scopes
  scope :by_name, -> (name) {where("name like ?", "%#{name}%")}
  scope :by_genre, ->(genre) {where("genre = ?",genre)}
  scope :by_id, ->(id) {find(id)}
  scope :date, ->(date) {joins(:demandes).where('demandes.start_date <> ?', date)}
  #nested attr
  accepts_nested_attributes_for :membres, :allow_destroy => true, reject_if: ->(attributes){ attributes['nom'].blank? && attributes['instrument'].blank? }
 accepts_nested_attributes_for :utilises, :allow_destroy => true, reject_if: ->(attributes){ attributes['materiel'].blank? }
  #validation
  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :date_de_creation, presence: true
  validates :genre,presence: true
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  include MultiStepModel

  def self.total_steps
    3
  end


end

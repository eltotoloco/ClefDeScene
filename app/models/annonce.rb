class Annonce < ApplicationRecord

	include Filterable

	mount_uploader :avatar, AvatarUploader

	belongs_to :user
	has_many :membres, :inverse_of => :annonce, dependent: :delete_all
	has_many :utilises, :inverse_of => :annonce, dependent: :delete_all
	has_many :demandes, :inverse_of => :annonce, dependent: :delete_all

    #scopes
    scope :groups, -> { where(type: 'Group') } 
    scope :photographers, -> { where(type: 'Photographer') }
    scope :by_name, -> (name) {where("name like ?", "%#{name}%")}
    scope :by_style, ->(style) {where("style = ?",style)}
    scope :by_id, ->(id) {find(id)}
    scope :date, ->(date) {joins(:demandes).where('demandes.start_date <> ?', date)}
  #nested attr
  accepts_nested_attributes_for :membres, :allow_destroy => true, reject_if: ->(attributes){ attributes['nom'].blank? && attributes['instrument'].blank? }
  accepts_nested_attributes_for :utilises, :allow_destroy => true, reject_if: ->(attributes){ attributes['materiel'].blank? }
  #validation
  validates :type, presence: true

  validates :name, uniqueness: { case_sensitive: false }, presence: true 
  validates :experience, presence: true
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  include MultiStepModel
  def self.total_steps
  	3
  end


  def self.types
  	%w(Group Photographer)
  end
  
  def self.select_options
  	descendants.map{ |c| c.to_s }.sort
  end

end

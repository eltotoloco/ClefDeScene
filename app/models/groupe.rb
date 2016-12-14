class Groupe < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :user
  has_many :membres, :inverse_of => :groupe, dependent: :destroy
  has_many :utilises, :inverse_of => :groupe, dependent: :destroy
  has_many :demandes, :inverse_of => :groupe
  accepts_nested_attributes_for :membres, :allow_destroy => true
  accepts_nested_attributes_for :utilises, :allow_destroy => true
  validates :name, uniqueness: { case_sensitive: false }, presence: true

  def self.search(search)
  	if search
  		where("name like ?", "%#{search}%")
  	else
  		all
  	end
  end
  def self.searchDate(date)
  	if search
  		joins(:demande).where.not(:demandes => {:start_date => date})
  	else
  		all
  	end
  end

end

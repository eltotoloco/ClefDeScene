class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  enum role: [:user, :bar, :artist]
  has_many :created_demandes,    class_name: 'Demande', foreign_key: 'from_user_id'
  has_many :asked_demandes, class_name: 'Demande', foreign_key: 'to_user_id' 
  has_many :messages, :inverse_of => :user
  validates :nom, presence: true
  has_many :annonces, dependent: :delete_all

  scope :by_id, ->(id) {find(id)}

  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
  	self.role ||= :user
  end
end

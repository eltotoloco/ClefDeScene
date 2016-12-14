class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  enum role: [:user, :bar, :groupe]
  has_many :demandes, :inverse_of => :user

  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
  	self.role ||= :user
  end
end

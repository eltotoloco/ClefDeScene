class Profile 

  include ActiveModel::Model

  attr_accessor :user, :groupe, :demandes

  validates :user, presence: true

end

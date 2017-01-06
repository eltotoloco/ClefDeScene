class Profile 

  include ActiveModel::Model

  attr_accessor :user, :annonces, :demandes

  validates :user, presence: true

end

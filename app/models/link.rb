class Link < ApplicationRecord
	  validates :url, presence: true
	  belongs_to :annonce


  def self.sites
  	%w(Facebook SoundCloud Other)
  end
end

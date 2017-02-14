class Message < ApplicationRecord
	belongs_to :demande
    scope :unread, -> { where(read: false) } 
    scope :to_user, ->(id) {where(to: id)}

	def readingmessage
		self.read ||= true
		save
	end
end

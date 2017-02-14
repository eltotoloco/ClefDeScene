class Audio < Preview; 

	mount_uploader :file, AudioUploader
	validates_integrity_of  :file
	validates_processing_of :file

	validate :file_type

	def file_type
		Rails.logger.debug "blleeeh"
		Rails.logger.debug file.content_type
	end
end
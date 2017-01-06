class Audio < Preview; 

	  mount_uploader :file, AudioUploader
	validates_integrity_of  :file
	validates_processing_of :file
end
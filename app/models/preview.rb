class Preview < ApplicationRecord
  include Rails.application.routes.url_helpers


  belongs_to :annonce
  scope :audios, -> { where(type: 'Audio') } 
  scope :images, -> { where(type: 'Image') }
  validates :annonce, presence: true
  validates :file, presence: true
  #validate :file_type_ok
  #validates_integrity_of :file



  def file_type_ok
    content_type = file.content_type
    Rails.logger.debug type.downcase
    Rails.logger.debug content_type
    if(!content_type.include?(type.downcase))
      errors.add(:file, "Erreur de type")
    end
  end
 # We will need a way to know which animals
    # will subclass the Animal model
    def self.types
    	%w(Preview Audio Image Video)
    end

    def to_jq_upload
      {
        "name" => read_attribute(file),
        "url" => file.url,
        "size" => file.size,
        "delete_url" => preview_path(:id => id),
        "delete_type" => "DELETE"
      }
    end

  end

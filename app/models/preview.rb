class Preview < ApplicationRecord
  include Rails.application.routes.url_helpers

  mount_uploader :file, AvatarUploader

  belongs_to :annonce
  scope :audios, -> { where(type: 'Audio') } 
  scope :pictures, -> { where(type: 'Picture') }
  validates :file, presence: true
  after_initialize :set_default_type, :if => :new_record?


 # We will need a way to know which animals
    # will subclass the Animal model
    def self.types
    	%w(Preview Audio Picture Video)
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

    def set_default_type
    	self.type ||= "Picture"
    end
  end

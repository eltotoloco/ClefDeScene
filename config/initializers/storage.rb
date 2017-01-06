CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV["aws_access_id"],
    aws_secret_access_key: ENV["aws_access_secret_key"],
    region: 'us-west-2',
    endpoint: 'https://s3-us-west-2.amazonaws.com/'

  }
  Rails.logger.debug "storage"
  config.fog_directory  = "test-compart-avatar"
  config.fog_public     = false
  config.fog_authenticated_url_expiration = 600
end
CarrierWave.configure do |config|

  # Choose what kind of storage to use for this uploader:
  #storage :file

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:                'us-west-2'
   }
   config.fog_directory  = 'awesome-answers-images'
   config.fog_public     = false                                        # optional, defaults to true
   config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end

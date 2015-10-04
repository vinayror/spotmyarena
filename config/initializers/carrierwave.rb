CarrierWave.configure do |config|
  config.fog_credentials = { 
      :provider               => 'AWS',
      :aws_access_key_id      => '',
      :aws_secret_access_key  => '',
      :region  => 'us-west-2'
  }
  config.cache_dir = "#{Rails.root}/tmp/uploads" 
  config.fog_directory  = 'spotmyarena'
end
CarrierWave.configure do |config|
  config.fog_credentials = { 
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAIL4RQV2D4DZQDPUA',
      :aws_secret_access_key  => '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',
      :region  => 'us-west-2'
  }
  config.cache_dir = "#{Rails.root}/tmp/uploads" 
  config.fog_directory  = 'spotmyarena/uploads'
end

# Access Key ID: AKIAIL4RQV2D4DZQDPUA
# Secret Access Key: 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

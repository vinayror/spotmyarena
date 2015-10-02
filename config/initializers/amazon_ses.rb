require 'aws/ses'
ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  access_key_id: 'AKIAIQDKTAKA23FZGZKQ',
  secret_access_key: 'AkGClqXIo75gK+hoeYcL8bCHugPU2kbKNA2GyBpZko5p'

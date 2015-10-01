class UserDeviseMailer < Devise::Mailer
  #helper :application # gives access to all helpers defined within `application_helper`.
  
  default template_path: 'devise/mailer', from: "SpotMyArena <support@spotmyarena.com>" # to make sure that your mailer uses the devise views

end
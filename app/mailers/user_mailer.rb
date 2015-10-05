class UserMailer < ActionMailer::Base
  default from: "Spotmyarena <support@spotmyarena.com>"

  include Mail::Utilities

  def transaction_success user, transaction_id, amount
    @user = user
    @transaction_id = transaction_id
    @amount = amount
    mail(:to => @user.email,
         :subject => "successfully transaction!!!!")
  end
end

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

  def discard_reciept(user, reason, slot, booking_date, ground)
  	@user = user
  	@reason = reason
  	@slot = slot
  	@booking_date = booking_date
  	@ground = ground
    mail(:to => @user.email,
         :subject => "cancelation request discard!!!!")
  end

  def accept_reciept(user, slot, booking_date, ground)
  	@user = user
  	@slot = slot
  	@booking_date = booking_date
  	@ground = ground
    mail(:to => @user.email,
         :subject => "cancelation request approved!!!!")
  end
end

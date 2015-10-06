class CancelBooking < ActiveRecord::Base
  belongs_to :user

  def requestd_uer
  	user = User.find(self.user_id)
  	user.email
  end

  def ground_name
  	ground = Ground.find(self.ground_id)
  end

  def booking_time
  	booking_time = BookingTime.find(self.booking_time_id)
  	booking_time.slot 
  end

  def booking_date
  	booking_time = BookingTime.find(self.booking_time_id).booking_date.date_of_booking
  end
end

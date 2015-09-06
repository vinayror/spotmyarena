	class BookingTime < ActiveRecord::Base
	  belongs_to :booking_date
	  belongs_to :booking
	  belongs_to :timeslot

	  #validates_uniqueness_of :time_of_booking

	  def ground_details
	  	self.booking_date.ground
	  end
	end

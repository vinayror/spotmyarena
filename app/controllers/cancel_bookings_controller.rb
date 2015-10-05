class CancelBookingsController < ApplicationController
  def index
  	@cancel_bookings = current_user.cancel_bookings
  end

  def new
  	@cancel_booking = CancelBooking.new
  end

  def create
  end
end

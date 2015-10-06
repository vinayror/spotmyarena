class CancelBookingsController < ApplicationController
  def index
  	@cancel_bookings = current_user.cancel_bookings
  end

  def new
  	@cancel_booking = CancelBooking.new
  end

  def request_approved
  	cancel_booking = CancelBooking.find(params[:cancel_booking_id])
  	slot = params[:slot]
  	booking_date = params[:booking_date]
  	ground = params[:ground]
  	cancel_booking.update(approved: true)
  	user = User.find(cancel_booking.user_id)
 	UserMailer.accept_reciept(user, slot, booking_date, ground).deliver
   	respond_to do |format|
      format.js { flash[:notice] = "approved successfully."}
  	end
  end

  def request_discard
 	cancel_booking = CancelBooking.find(params[:cancel_booking_id])
 	reason = params[:reason]
  	slot = params[:slot]
  	booking_date = params[:booking_date]
  	ground = params[:ground]
 	cancel_booking.update(response_message: reason, discard: true)
 	user = User.find(cancel_booking.user_id)
 	UserMailer.discard_reciept(user, reason, slot, booking_date, ground).deliver
 	respond_to do |format|
      format.html { redirect_to cancelation_request_path, notice: 'discard successfully.' }
      format.json { head :no_content }
    end
  end
end

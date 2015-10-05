class RemoveTimeOfBookingFromBookingTimes < ActiveRecord::Migration
  def change
    remove_column :booking_times, :time_of_booking, :datetime
  end
end

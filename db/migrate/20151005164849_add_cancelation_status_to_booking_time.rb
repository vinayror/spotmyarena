class AddCancelationStatusToBookingTime < ActiveRecord::Migration
  def change
    add_column :booking_times, :cancelation_status, :string
  end
end

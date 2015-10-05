class AddResponseMessageToCancelBooking < ActiveRecord::Migration
  def change
    add_column :cancel_bookings, :response_message, :text
  end
end

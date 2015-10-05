class AddSlotPriceToBookingTime < ActiveRecord::Migration
  def change
    add_column :booking_times, :slot_price, :float
  end
end

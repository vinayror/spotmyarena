class AddPersonIdToBookingTime < ActiveRecord::Migration
  def change
    add_column :booking_times, :person_id, :integer
  end
end

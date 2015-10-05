class CreateCancelBookings < ActiveRecord::Migration
  def change
    create_table :cancel_bookings do |t|
      t.integer :user_id
      t.integer :ground_id
      t.integer :booking_time_id
      t.text :description
      t.boolean :approved
      t.boolean :discard

      t.timestamps null: false
    end
  end
end

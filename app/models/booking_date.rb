class BookingDate < ActiveRecord::Base
  belongs_to :ground
  has_many :booking_times
  accepts_nested_attributes_for :booking_times, reject_if: :all_blank, allow_destroy: true

  validates_uniqueness_of :date_of_booking
end

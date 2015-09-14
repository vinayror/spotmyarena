class Ground < ActiveRecord::Base
  CATEGORY = ["Tabel Tennis", "BadMinton", "Cricket Nets",  "Snooker", "Tennis"]
  CITY =['Delhi']
  AREA =['Connaught Place', 'Chanakyapuri', 'Delhi Cantonment', 'Vasant Vihar', 'North Delhi', 'Narela' ,'Model Town', 'Narela', 'Alipur', 'North West Delhi', 'Kanjhawala', 'Rohini', 'Kanjhawala', 'Saraswati Vihar', 'West Delhi', 'Rajouri Garden', 'Patel Nagar', 'Punjabi Bagh', 'South West Delhi', 'Dwarka', 'Najafgarh', 'Kapashera', 'South Delhi', 'Saket', 'Hauz Khas', 'Mehrauli', 'South East Delhi', 'Defence Colony', 'Lajpat Nagar', 'Kalkaji', 'Sarita Vihar', 'Central Delhi', 'Daryaganj', 'Karol Bagh', 'Kotwali', 'Civil Lines', 'North East Delhi', 'Seelampur', 'Yamuna Vihar', 'Karawal Nagar', 'Shahdara',  'Seemapuri', 'Vivek Vihar', 'East Delhi', 'Preet Vihar', 'Gandhi Nagar', 'Mayur Vihar']

  belongs_to :user
  has_many :booking_dates, :dependent => :destroy
  has_many :ground_attachments, :dependent => :destroy

  validates :weekday_price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0, :message => "only allow digits"} 
  validates :weekend_price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0, :message => "only allow digits"} 

  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :area
  #validates_numericality_of :value, :on => :create
  acts_as_commontable
  
  ratyrate_rateable 'visual_effects', 'original_score', 'director', 'custome_design'

  accepts_nested_attributes_for :ground_attachments, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :booking_dates, reject_if: :all_blank, allow_destroy: true

  attr_accessor :start_date, :end_date, :closing_date, :closing_time
  def self.search(category, city, area, date)
    if category.present? || city.present? || area.present? || date.present?
      self.joins(:booking_dates).where('grounds.category = ? OR city = ? OR area = ? OR booking_dates.date_of_booking = ?', category, city, area, date)
      #self.joins(:booking_dates).where('grounds.category = ? AND city = ? AND area = ? AND booking_dates.date_of_booking = ?', category, city, area, date)
    else
      all
    end
  end

  def set_date_and_time(start_date, end_date)
    ground_id = self.id
    if start_date.present? && end_date.present?
      start_date = start_date.to_date
      end_date = end_date.to_date
      (start_date..end_date).each do |d|
        BookingDate.create(date_of_booking: d, ground_id: self.id, status: true)
      end
      booking_dates = self.booking_dates
      timeslots = ["12:00 AM","01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM", "06:00 AM", "07:00 AM", "08:00 AM", "09:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "01:00 PM", "02:00 PM", "03:00 PM", "04:00 PM", "05:00 PM", "06:00 PM", "07:00 PM", "08:00 PM", "09:00 PM", "10:00 PM", "11:00 PM"]
      
      booking_dates.each do |d|
        timeslots.each do |t|
          BookingTime.create(slot: t, status: true, booking_date_id: d.id)
        end
      end
    end
  end

  def ground_status
    if self.status == true
      "Available"
    elsif self.status == false
      "Not-available"
    end
  end


  def day_price
    (self.weekday_price * 10)/100
  end

  def end_price
    (self.weekend_price * 10)/100
  end
end

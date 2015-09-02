class Ground < ActiveRecord::Base
CATEGORY = ["Tabel Tennis", "BadMinton", "Cricket Nets",  "Snooker", "Tennis"]
CITY =['Delhi']
AREA =['Connaught Place', 'Chanakyapuri', 'Delhi Cantonment', 'Vasant Vihar', 'North Delhi', 'Narela' ,'Model Town', 'Narela', 'Alipur', 'North West Delhi', 'Kanjhawala', 'Rohini', 'Kanjhawala', 'Saraswati Vihar', 'West Delhi', 'Rajouri Garden', 'Patel Nagar', 'Punjabi Bagh', 'South West Delhi', 'Dwarka', 'Najafgarh', 'Kapashera', 'South Delhi', 'Saket', 'Hauz Khas', 'Mehrauli', 'South East Delhi', 'Defence Colony', 'Lajpat Nagar', 'Kalkaji', 'Sarita Vihar', 'Central Delhi', 'Daryaganj', 'Karol Bagh', 'Kotwali', 'Civil Lines', 'North East Delhi', 'Seelampur', 'Yamuna Vihar', 'Karawal Nagar', 'Shahdara',  'Seemapuri', 'Vivek Vihar', 'East Delhi', 'Preet Vihar', 'Gandhi Nagar', 'Mayur Vihar']

  belongs_to :user
  has_many :booking_dates
  accepts_nested_attributes_for :booking_dates, reject_if: :all_blank, allow_destroy: true

  def self.search(category, city, area, date)
    if category.present? || city.present? || area.present? || date.present?
      #self.joins(:booking_dates).where('grounds.category = ? OR city = ? OR area = ? OR booking_dates.date_of_booking = ?', category, city, area, date)
      self.joins(:booking_dates).where('grounds.category = ? AND city = ? AND area = ? AND booking_dates.date_of_booking = ?', category, city, area, date)
    else
      all
    end
  end
end

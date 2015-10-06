class HomeController < ApplicationController
  before_action :authenticate_user! , only: [:profile]
  def index
  end

  def profile
  	
  end

  def about_us
  	
  end

  def service
  	
  end

  def faq
  	
  end

  def contact
  	
  end

  def newly_added_ground
    @added_grounds = Ground.where("created_at >= ? AND publish = ?", 1.week.ago.utc, false).order("created_at DESC")
  end

  def cancelation_request
    @cancelation_requestes = CancelBooking.where("created_at >= ?", 1.week.ago.utc).order("created_at DESC")
  end

  def transaction_history
    @transaction_history = Transaction.where("created_at >= ?", 1.week.ago.utc).order("created_at DESC")
  end
end

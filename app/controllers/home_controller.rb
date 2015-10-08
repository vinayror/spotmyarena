class HomeController < ApplicationController
  before_action :authenticate_user! , only: [:profile]
  before_filter :is_admin?

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

  def contact_mail
    name = params[:name]
    email = params[:email]
    message = params[:message]
    UserMailer.contact_mail(name, email, message).deliver
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'successfully contacted to spotmyarena.' }
      format.json { head :no_content }
    end
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

  def is_admin?
    redirect_to admin_root_path if (current_admin_user)
  end
end

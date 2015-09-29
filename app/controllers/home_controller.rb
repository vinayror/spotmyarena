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
end

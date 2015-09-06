class HomeController < ApplicationController
  before_action :authenticate_user! , only: [:profile]
  def index
  end

  def profile
  	
  end

  def about
  	
  end

  def contact
  	
  end

  def terms_of_service
  	
  end

  def faq
  	
  end
end

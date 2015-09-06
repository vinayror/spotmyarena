class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  #check_authorization
  #load_and_authorize_resource
  
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token
  #before_action :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', :alert => exception.message
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # def after_sign_in_path_for(resource) 
  #   edit_user_registration_path
  # end 

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password) }
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :username, :mobile, :age, :role) }
  end

end

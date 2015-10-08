class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :js
  
  before_filter :configure_permitted_parameters
  

  def new
    super
  end

 
  def create
    @user = User.new sign_up_params
    if @user.save
      flash[:notice] = "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."
      redirect_to root_url
    else
      flash[:notice] = "invalid email address"
      render :action => :new
    end
  end


  protected
  def after_update_path_for resource
    edit_user_registration_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :email, :mobile, :password, :password_confirmation, :provider, :uid, :oauth_token, :oauth_expires_at, :role, :confirmed_at, :confirmation_token)
    end
    
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :mobile, :age, :avatar, :city, :address, :provider, :uid, :oauth_token, :oauth_expires_at, :role, :confirmed_at, :confirmation_token)
    end
  end

  def after_sign_up_path_for(resource)
    root_path
  end 

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
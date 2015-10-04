class Users::ConfirmationsController < Devise::ConfirmationsController
  def create
	  self.resource = resource_class.send_confirmation_instructions(params[resource_name])

	  if successful_and_sane?(resource)
	    set_flash_message(:notice, :send_instructions) if is_navigational_format?
	    respond_with({}, :location => after_resending_confirmation_instructions_path_for(resource_name))
	  else
	    respond_with_navigational(resource){ render_with_scope :new }
	  end
	end

  protected
    def after_confirmation_path_for resource_name, resource
      sign_in(resource_name, resource)
      super
    end
end
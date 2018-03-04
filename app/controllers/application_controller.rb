class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation]) 
            devise_parameter_sanitizer.permit(:account_update, keys: [:name, :is_female, :date_of_birth, :email, :password, :password_confirmation, :current_password]) 
        end

        private

  			# Overwriting the sign_out redirect path method
  		def after_sign_out_path_for(resource_or_scope)
    			root_path
 		end
end


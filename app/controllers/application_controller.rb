class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :configure_permitted_parameters, if: :devise_controller?

    protected
      # Costum devise parameters allows the user to add a name a sign up
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation]) 
            devise_parameter_sanitizer.permit(:account_update, keys: [:name, :is_female, :date_of_birth, :email, :password, :password_confirmation, :current_password]) 
        end

        private

  			# Overwriting the sign_out redirect path method
  		def after_sign_out_path_for(resource_or_scope)
    			root_path
 		  end

        # Overwriting the sign_in redirect path method
      def after_sign_in_path_for(resource_or_scope)
          "/users/#{current_user.id}"
      end
end



class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:fname, :lname, :avatar])
    end
end
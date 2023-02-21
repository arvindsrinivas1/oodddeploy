class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :authenticate_valid_user!, only: [:new, :edit, :update, :destroy]

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :username, :credit_card, :phone_number, :address])
    end
end

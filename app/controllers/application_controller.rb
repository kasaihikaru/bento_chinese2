class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :study_ja, :image, :blog, :introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :study_ja, :image, :blog, :introduction])
  end
end

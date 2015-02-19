class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  # protect_from_forgery with: :exception
  after_filter :set_access_control_headers
  def after_sign_in_path_for(resource)
    if resource.us_citizen.blank? && resource.uk_citizen.blank? && resource.not_us_uk_citizen.blank?
      analysis_path
    else  
      investment_path
    end
  end
  private


 def set_access_control_headers
   headers['Access-Control-Allow-Origin'] = "*"
   headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
 end
 
  
  protected
  def configure_permitted_parameters
	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email,:password) }
	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email,:password,:first_name,:last_name,:country) }
  end	  
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    if headcoach_signed_in?
      headcoach_path(current_headcoach.id)
    elsif coach_signed_in?
      coach_path(current_coach.id)
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation)}
  end


end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  
  # Only permit admins
  def require_admin!
  	authenticate_user!

  	if current_user && !current_user.admin?
  		render_404
  	end
  end
  helper_method :require_admin!

  def peek_enabled?
    current_user.try(:admin?)
  end

  def render_404
    render: file: Rails.root.join("public", "404"), layout: false, status: 404
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :firstname << :lastname
  end

end

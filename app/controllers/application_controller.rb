class ApplicationController < ActionController::Base
  respond_to :html, :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!, except: :index
  before_action :configure_permitted_parameters, if: :devise_controller?
  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  # skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  # default action to render view
  def index

  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }
  end
end

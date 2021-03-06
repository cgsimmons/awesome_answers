class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def user_signed_in?
    session[:user_id].present? && user_valid?
  end
  helper_method :user_signed_in?   #makes method accessible in views

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?
  end
  helper_method :current_user

# only used in controllers
  def authenticate_user
    redirect_to new_session_path, alert: 'Please sign in.' unless user_signed_in?
  end

  def user_valid?
    if User.find_by(id: session[:user_id]).present?
      true
    else
      reset_session
      false
    end
  end

end

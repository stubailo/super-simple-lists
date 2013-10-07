class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, :with => :access_denied

  protected
    
    def access_denied
      if current_user
        redirect_to root_path, notice: "You weren't authorized to #{params[:action]} in #{params[:controller]}"
      else
        redirect_to new_user_session_path, notice: "Please log in to access your lists!"
      end
    end

end

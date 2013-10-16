class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, :with => :access_denied

  protected
    
    # rescue from cancan error
    def access_denied
      if current_user
        redirect_to root_path, error: "you weren't authorized to #{params[:action]} in #{params[:controller]}"
      else
        # the problem is almost certainly lack of login
        redirect_to new_user_session_path
      end
    end

end

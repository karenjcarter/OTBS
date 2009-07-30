# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
 include ApplicationHelper

 # before_filter :check_authorization
  before_filter :get_pages_for_tabs
  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_otbs_session_id'
  
  # Check for a valid authorization cookie, possibly logging the user in.
  def check_authorization
    authorization_token = cookies[:authorization_token]
    if authorization_token and not logged_in?
      user = User.find_by_authorization_token(authorization_token)
      user.login!(session) if user
    end
  end

  # Protect a page from unauthorized access.
  def protect
  unless logged_in?
    session[:protected_page] = request.request_uri
    flash[:notice] = "Please log in first"
    redirect_to :controller => "user", :action => "login"
    return false
  end
  end
  
  def get_pages_for_tabs
    if logged_in?
      @tabs = Page.find_main
    else
        @tabs = Page.find_main_public
    end
    
  end

end

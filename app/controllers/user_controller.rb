require 'digest/sha1'
class UserController < ApplicationController

# This will be a protected page for viewing user information.
 before_filter :protect, :only => [:index, :edit]

def current_user
	@title = "Online Taxi Booking System User Portal"
	@user = User.find(session[:user_id])
end

def show
	@title = "Online Taxi Booking System User Portal"
	@user = User.find(session[:user_id])
end

def list_users
	@title = "Online Taxi Booking System User Portal"
	@users = User.find(:all)
	@user = User.find(session[:user_id])
	respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @user }
	end
end

def register
	@title = "Register"
	if param_posted?(:user)
		@user = User.new(params[:user])
		if @user.save
			@user.login!(session)
			flash[:notice] = "User #{@user.screen_name} created!"
			redirect_to_forwarding_url
		else
			@user.clear_password!
		end
	end
end

  
 def login
  @title = "Log in to the Online Taxi Booking System"
  if request.get?
    @user = User.new(:remember_me => cookies[:remember_me] || "0")
  elsif param_posted?(:user)
    @user = User.new(params[:user])
    user = User.find_by_screen_name_and_password(@user.screen_name,@user.password)
    if user
		user.login!(session)
		if @user.remember_me == "1"
			cookies[:remember_me] = { :value   => "1",
                                :expires => 10.years.from_now }
			 user.authorization_token = Digest::SHA1.hexdigest(
                                       "#{user.screen_name}:#{user.password}")
			user.save!
			cookies[:authorization_token] = {
				:value   => user.authorization_token.to_s,
				:expires => 10.years.from_now }
		else
			cookies.delete(:remember_me)
			cookies.delete(:authorization_token)
		end

		flash[:notice] = "User #{user.screen_name} logged in!"
		redirect_to_forwarding_url
    else
	      # Don't show the password in the view.
	      @user.clear_password!
	      flash[:notice] = "Invalid screen name/password combination"
    end
  end
end

def logout
  User.logout!(session, cookies)
  flash[:notice] = "Logged out"
  redirect_to :action => "index", :controller => "site"
end

# Edit the user's basic info.
def edit
  @title = "Edit basic info"
  @user = User.find(session[:user_id])
  if param_posted?(:user)
    attribute = params[:attribute]
    case attribute
    when "email"
      try_to_update @user, attribute
    when "password"
      if @user.correct_password?(params)
        try_to_update @user, attribute
      else
        @user.password_errors(params)
      end
    end
  end
  # For security purposes, never fill in password fields.
  @user.clear_password!
end


 # Return true if a parameter corresponding to the given symbol was posted.
def param_posted?(symbol)
  request.post? and params[symbol]
end

# Redirect to the previously requested URL (if present).
def redirect_to_forwarding_url
  if (redirect_url = session[:protected_page])
    session[:protected_page] = nil
    redirect_to redirect_url
  else
    redirect_to :action => "index"
  end
end

# Try to update the user, redirecting if successful.
def try_to_update(user, attribute)
  if user.update_attributes(params[:user])
    flash[:notice] = "User #{attribute} updated."
    redirect_to :action => "index"
  end
end


end
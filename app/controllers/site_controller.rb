class SiteController < ApplicationController

  def index
	  @title = "Welcome to the Online Taxi Booking System!"
	  @username = session[:screen_name]
  end

  def about
	   @title = "About the Online Taxi Booking System"
end

  def help
	  @title = "Online Taxi Booking Help"
  end
  
end
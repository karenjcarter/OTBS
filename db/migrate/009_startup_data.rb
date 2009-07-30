class StartupData < ActiveRecord::Migration
  
  def self.up
	
	Page.create(:name => 'wikihome', :title => 'Home of the Wiki about Nothing', :navlabel => 'Our Wiki', :position => 1, 
		:admin => false, :username => 'TestUser', 
		:body => 'h1. Welcome to the Wiki About Nothing')
		
	Passenger.create(:name => 'Sherlock', :contact_number => '0078699', :suburb_origin => 'Kowloon', :street => 'Baker Street', 
		:street_number => '42', :building => 'Unit', :suburb_destination => 'Hawke Bay', :passenger_number => 1, :taxi_type => 'Sedan', 
		:date =>'01/01/2009', :time_required => '07:30')
	
	Post.create(:title => 'First Post', :body => 'This is the first post in the Taxi Blog', :username => 'TestUser')
	
	User.create(:screen_name => 'TestUser', :email => 'testuser@hotmail.com', :password => 'xyz123')
end
 
  def self.down
  end
  
end
 
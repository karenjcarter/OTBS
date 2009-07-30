class Passenger < ActiveRecord::Base
	
	validates_presence_of     :name, :contact_number, :street, :suburb_origin, :street_number, :suburb_destination, :passenger_number, :date, :time_required, :taxi_type
	validates_length_of       :name, :street, :suburb_origin, :suburb_destination ,  :within => 3..40
	validates_length_of	:contact_number, :minimum => 6
	validates_numericality_of :contact_number
	validates_uniqueness_of :name, :scope => [:date, :time_required], :message => " input already has a taxi booked for this date and time"
end

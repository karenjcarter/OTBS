class PassengersController < ApplicationController
	
  before_filter :protect
  
  # GET /passengers
  # GET /passengers.xml
  def index
    @passengers = Passenger.find(:all)
    @title = "Current Bookings"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @passengers }
    end
  end

  # GET /passengers/1
  # GET /passengers/1.xml
  def show
    @passenger = Passenger.find(params[:id])
    @title = "Booking Details"
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @passenger }
    end
  end

  # GET /passengers/new
  # GET /passengers/new.xml
  def new
    @passenger = Passenger.new
    @title = "Book a Taxi"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @passenger }
    end
  end

  # GET /passengers/1/edit
  def edit
    @title = "Edit a Booking"
    @passenger = Passenger.find(params[:id])
  end

  # POST /passengers
  # POST /passengers.xml
  def create
      @passenger = Passenger.new(params[:passenger])
      @title = "Booking successful"
    respond_to do |format|
      if @passenger.save
        flash[:notice] = 'Booking was successfully created.'
        format.html { redirect_to(@passenger) }
        format.xml  { render :xml => @passenger, :status => :created, :location => @passenger }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @passenger.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
   # PUT /passengers/1
  # PUT /passengers/1.xml
  def update
    @passenger = Passenger.find(params[:id])
    @title = "Edit a Booking"
    respond_to do |format|
      if @passenger.update_attributes(params[:passenger])
        flash[:notice] = 'Booking was successfully updated.'
        format.html { redirect_to(@passenger) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @passenger.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /passengers/1
  # DELETE /passengers/1.xml
  def destroy
    @passenger = Passenger.find(params[:id])
    @passenger.destroy

    respond_to do |format|
      format.html { redirect_to(passengers_url) }
      format.xml  { head :ok }
    end
  end
end

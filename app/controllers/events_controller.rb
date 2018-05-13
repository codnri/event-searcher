class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
    

  def index
    @events = Event.all
  end
  
  def new
    @event = Event.new
  end
  
  def show
    # @event = Event.find(params[:id])
  end
  
  def edit
    # @event = Event.find(params[:id])
  end
  
    
  def create
    p current_user
    @event = current_user.events.new(event_params)
    # @event = Event.new(event_params)
    if @event.save
      flash.notice = "Event has been created successfully"
      redirect_to event_path @event
    else
      flash.alert = "Event has not been created"
      render :new
    end
  end
  
  def update
    @event = Event.find(params[:id])
    #@event = current_user.events.new
    # @event = Event.new(event_params)
    if @event.update(event_params)
      flash.notice = "Event has been updated successfully"
      redirect_to event_path @event
    else
      flash.alert = "Event has not been updated"
      render :edit
    end
  end

  
  def destroy
    #@event = Event.find(params[:id])

    @event.destroy
    flash.notice= "Exercise has been deleted"
    redirect_to root_path
  end
  
  
  private
    def event_params
      params.require(:event).permit(:subject, :description, :venue, :event_date, :event_price, :purchase_id)
    end

    def set_event
        @event = Event.find(params[:id])
    end
end

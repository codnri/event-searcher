class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  

  def index
    if search_word =  params[:search]
      @events = Event.where("subject LIKE :word OR description LIKE :word", word: "\%#{search_word}\%")  
      
      # テーブル名.where("カラム1 LIKE :hoge OR カラム2 LIKE :hoge", hoge: "\%#{検索値}\%")

    else
    @events = Event.all
    end
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

    @event = current_user.events.new(event_params)
    convert_dollar_to_cent
    if @event.save
      flash.notice = "Event has been created successfully"
      redirect_to event_path @event
    else
      flash.alert = "Event has not been created"
      render :new
    end
  end
  
  def update
    @event.attributes = event_params
    convert_dollar_to_cent
    if @event.save
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
    flash.notice= "Event has been deleted"
    redirect_to root_path
  end
  
  
  private
    def event_params
      params.require(:event).permit(:subject, :description, :venue, :event_date, :event_price, :purchase_id)
    end

    def set_event
        @event = Event.find(params[:id])
    end
    
    def convert_dollar_to_cent
      @event.event_price = @event.event_price * 100
    end
    
    
end

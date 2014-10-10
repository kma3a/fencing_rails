class EventsController < ApplicationController
  before_filter :authenticate!, except: [:show]

  def new
    @event = Event.new()
  end
  
  def create
    @event = Event.new({event_title: params[:event][:event_title], participant_count: params[:event][:participant_count], team_id: params[:team_id]})
    if @event.save
      redirect_to event_path(@event.id)
    end
  end

  def show

  end

  private

  def authenticate!
    if headcoach_signed_in?
    
    else
      authenticate_coach!
    end
  end


end

class EventsController < ApplicationController
  before_filter :authenticate!, except: [:show]

  def new
    @event = Event.new()
    @team = Team.find(params[:team_id])
  end
  
  def create
    @team = Team.find(params[:team_id])
    @event = Event.new({event_title: params[:event][:event_title], participant_count: params[:event][:participant_count], team_id: params[:team_id]})
    if @event.save
      redirect_to team_event_path(@team, @event.id)
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

class EventsController < ApplicationController
  before_filter :authenticate!, except: [:show]

  def new
    @event = Event.new()
    @team = Team.find(params[:team_id])
  end
  
  def create
    @team = Team.find(params[:team_id])
    @event = Event.new({event_title: params[:event][:event_title],participant_count: params[:event]["participants"].count, team_id: params[:team_id]})
    if @event.save
      @event.add_participants(params[:event]["participants"]).each_with_index do |part,index|
         Participant.create(student_id: part.id, event_id: @event.id, bout_number: index + 1)
      end
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

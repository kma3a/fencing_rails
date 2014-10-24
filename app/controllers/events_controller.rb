class EventsController < ApplicationController
  before_filter :authenticate_coach!, except: [:publicshow, :show]

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
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @participants = @event.participants.order("bout_number ASC")
  end
  
  def publicshow
    @event = Event.find_by(secret_key: params[:event][:secret_key])
    @participants = @event.participants.order("bout_number ASC")
    render 'show'
  end

  def bout
    @event = Event.find(params[:id])
    @part1 = Participant.find_by(event_id: params[:id], bout_number: params[:part1])
    @part2 = Participant.find_by(event_id: params[:id], bout_number: params[:part2])
    render 'bout'
  end

  def bout_update 
    @event = Event.find(params[:id])
    @part1 = Participant.find_by(event_id: params[:id], bout_number: params[:part1])
    @part2 = Participant.find_by(event_id: params[:id], bout_number: params[:part2])
    if params[:victory] == "1"
      @part1.update_bout(params[:part2].to_i, "V"<< params[:participant1][:bout_points])
      @part2.update_bout(params[:part1].to_i, "D"<< params[:participant2][:bout_points])
    else
      @part2.update_bout(params[:part1].to_i, "V"<< params[:participant2][:bout_points])
      @part1.update_bout(params[:part2].to_i, "D"<< params[:participant1][:bout_points])
    end
    redirect_to team_event_path(@event.team_id, @event.id)
  end

end

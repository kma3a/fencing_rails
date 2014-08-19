class TeamsController < ApplicationController

  def new
    @team = Team.new()
  end
  
  def create
    p params
    @team = Team.create(name: params[:team][:name], headcoach_id: current_headcoach.id)
    if @team
      redirect_to headcoach_path(current_headcoach.id)
    else
      render 'new'
    end
  end

end

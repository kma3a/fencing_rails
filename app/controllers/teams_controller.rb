class TeamsController < ApplicationController

  def new
    @team = Team.new()
  end
  
  def create
    @team = Team.create(name: params[:team][:name], headcoach_id: current_headcoach.id)
    if @team
      redirect_to headcoach_path(current_headcoach.id)
    else
      render 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def destroy
    p params
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to headcoach_path(current_headcoach.id)
  end

end

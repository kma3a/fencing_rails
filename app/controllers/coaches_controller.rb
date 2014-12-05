class CoachesController < ApplicationController
before_filter :authenticate_coach!

  def show
    @coach = Coach.find(params[:id])
    @owned_teams = @coach.owned_teams
    @teams = @coach.teams
  end

end

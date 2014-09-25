class CoachesController < ApplicationController
before_filter :authenticate_coach!

  def show
    @coach = Coach.find(params[:id])
  end

end

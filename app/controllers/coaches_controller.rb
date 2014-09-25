class CoachesController < ApplicationController
before_filter :autheticate_coach!

  def show
    @coach = Coach.find(params[:id])
  end

end

class HeadcoachesController < ApplicationController
  def show
    @headcoach = Headcoach.find(params[:id].to_i)
  end
end

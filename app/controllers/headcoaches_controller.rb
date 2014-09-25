class HeadcoachesController < ApplicationController
  before_filter :authenticate_headcoach!
  def show
    @headcoach = Headcoach.find(params[:id].to_i)
  end
end

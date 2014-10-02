class EventsController < ApplicationController
  before_filter :authenticate!, except: [:show]

  def new
    @event = Event.new()
  end

  private

  def authenticate!
    if headcoach_signed_in?
    
    else
      authenticate_coach!
    end
  end


end

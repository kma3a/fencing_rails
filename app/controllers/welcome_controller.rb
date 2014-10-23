class WelcomeController < ApplicationController
  def index
    @student = Student.new
    @event = Event.new

  end
end

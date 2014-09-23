class StudentsController < ApplicationController

  def new
    @student = Student.new()
  end

  def create
    @student = Student.create({name: params[:student][:name]})
    if @student
      redirect_to headcoach_path(current_headcoach.id)
    end
  end

end

class StudentsController < ApplicationController

  def new
    @student = Student.new()
  end

  def create
    @student = Student.create({name: params[:student][:name]})
    if @student
      redirect_to student_path(@student)
    end
  end

  def show
    @student = Student.find(params[:id])
  end

end

class StudentsController < ApplicationController

  def new
    @student = Student.new()
  end

  def create
    @student = Student.create!({name: params[:student][:name]})
      p @student
    if @student
      redirect_to student_path(@student.secret_key)
    end
  end

  def show
    @student = Student.find_by(secret_key: params[:id])
  end

end

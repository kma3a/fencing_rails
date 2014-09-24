class StudentsController < ApplicationController

  def new
    @student = Student.new()
  end

  def create
    @student = Student.new({name: params[:student][:name]})
    if @student.save
      redirect_to student_path(@student.secret_key)
    else
      render 'new'
    end
  end

  def show
    @student = Student.find_by(secret_key: params[:id])
  end

end

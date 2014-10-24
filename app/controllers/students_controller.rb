class StudentsController < ApplicationController
  before_filter :authenticate_coach!, except: [:show, :publicshow]

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

  def publicshow
    @student = Student.find_by(secret_key: params[:student][:secret_key])
    render 'show'
  end

  def edit
    @student = Student.find_by(secret_key: params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update({name:params[:student][:name]})
      redirect_to student_path(@student.secret_key)
    else
      render :edit
    end
  end

end

class TeamsController < ApplicationController

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new()
  end
  
  def create
    @team = Team.new(name: params[:team][:name], headcoach_id: current_headcoach.id)
    if @team.save
      redirect_to headcoach_path(current_headcoach.id)
    else
      render 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update({name:params[:team][:name]})
      redirect_to headcoach_path(current_headcoach.id)
    else
      render 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to headcoach_path(current_headcoach.id)
  end

  def add_coach
    @team = Team.find(params[:id])
    @coach = Coach.find_by({email: params[:coach][:email]})
    if  @coach && !@team.coaches.include?(@coach)
      @team.coaches << @coach
      redirect_to team_path(@team.id)
    else
      render 'edit'
    end
  end

  def remove_coach
    @team = Team.find(params[:id])
    @coach = Coach.find(params[:coach_id])
    @team.coaches.delete(@coach)
    redirect_to team_path(@team.id)
  end

  def add_student
    @team = Team.find(params[:id])
    @student = Student.find_by({secret_key: params[:student][:secret_key]})
    if @student && !@team.students.include?(@student)
      @team.students << @student
      redirect_to team_path(@team)
    else
      render 'show'
    end
  end

  def remove_student
    @team = Team.find(params[:id])
    @student = Student.find(params[:student_id])
    @team.students.delete(@student)
    redirect_to team_path(@team)
  end


end

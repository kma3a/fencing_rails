class TeamsController < ApplicationController
  before_filter :authenticate_coach!

  def show
    @team = Team.find(params[:id])
    @coaches = @team.coaches
    @students = @team.students
    @events = @team.events
  end

  def new
    @team = Team.new()
  end
  
  def create
    @team = Team.new(name: params[:team][:name], headcoach_id: current_coach.id)
    if @team.save
      redirect_to coach_path(current_coach.id)
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
      redirect_to coach_path(current_coach.id)
    else
      render 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to coach_path(current_coach.id)
  end

  def add_coach
    @team = Team.find(params[:id])
    @coach = Coach.find_by({email: params[:coach][:email]})
    if  @coach && !@team.coaches.include?(@coach)
      @team.coaches << @coach
      redirect_to team_path(@team.id)
    else
      @team.errors.add(:coach, "not found")
      render 'show'
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
    if !@student 
      @student = Student.new(name: params[:student][:secret_key])
      if @student.save
        @team.students << @student
        redirect_to team_path(@team)
      else
        @team.errors.add(:student, "not found")
        render 'show'
      end
    elsif !@team.students.include?(@student)
      @team.students << @student
      redirect_to team_path(@team)
    else
      @team.errors.add(:student, "already added")
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

class Student < ActiveRecord::Base
  has_many :team_students
  has_many :teams, through: :team_students
  has_many :participants
  has_many :events, through: :participants
end

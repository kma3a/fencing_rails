class Team < ActiveRecord::Base
  belongs_to :headcoach
  has_many :team_coaches
  has_many :coaches, through: :team_coaches
  has_many :team_students
  has_many :students, through: :team_students
  has_many :events

  validates_presence_of :name
end

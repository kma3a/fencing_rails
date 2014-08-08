class Team < ActiveRecord::Base
  belongs_to :headcoach
  has_many :team_coaches
  has_many :coaches, through: :teamcoaches
  has_many :team_students
  has_many :students, through: :team_students
  has_many :events
end

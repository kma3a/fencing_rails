class TeamCoach < ActiveRecord::Base
  belongs_to :team
  belongs_to :coach
end

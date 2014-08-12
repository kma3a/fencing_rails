class TeamStudent < ActiveRecord::Base
  belongs_to :team
  belongs_to :student
end

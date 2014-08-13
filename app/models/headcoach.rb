class Headcoach < ActiveRecord::Base
  has_many :teams
  devise :database_authenticatable, :registerable, :recoverable, :timeoutable
end

class Event < ActiveRecord::Base
  belongs_to :team
  has_many :participants
  has_many :studnets, through: :participants
end

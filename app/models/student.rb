require 'securerandom'
class Student < ActiveRecord::Base
  has_many :team_students
  has_many :teams, through: :team_students
  has_many :participants
  has_many :events, through: :participants

  before_validation :create_key
  validates_presence_of :name, :secret_key

  def create_key
    self.secret_key = SecureRandom.base64(9).sub(/[\/\\]/, "1")
  end
end

require 'securerandom'
class Student < ActiveRecord::Base
  has_many :team_students
  has_many :teams, through: :team_students
  has_many :participants
  has_many :events, through: :participants

  before_validation :create_key
  validates_presence_of :name, :secret_key

  private
  
  def create_key
    self.secret_key ||= SecureRandom.base64(9).gsub(/[^a-zA-z\d]/, Random.rand(9).to_s)
  end
end

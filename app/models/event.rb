require 'securerandom'

class Event < ActiveRecord::Base

  belongs_to :team
  has_many :participants
  has_many :students, through: :participants

  before_validation :create_key

  def create_key
    self.secret_key ||= SecureRandom.base64(9).gsub(/[^a-zA-z\d]/, Random.rand(9).to_s)
  end

  def add_participants(array)
    participants = []
    array.each do |participant|
      student = Student.find_by(secret_key: participant)
      if student != nil
        participants << student
      end
    end
    participants

  end

end

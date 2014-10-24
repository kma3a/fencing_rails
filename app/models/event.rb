require 'securerandom'

class Event < ActiveRecord::Base

  belongs_to :team
  has_many :participants
  has_many :students, through: :participants

  validates :event_title, presence: true

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
  
  def get_pool
    case self.participant_count
      when 4
        return [[1,4],[2,3],[1,3],[2,4],[3,4],[1,2]]
      when 5
        return [[1,2],[3,4],[5,1],[2,3],[5,4],[1,3],[2,5],[4,1],[3,5],[4,2]]
      when 6
        return [[1,2],[4,5],[2,3],[5,6],[3,1],[6,4],[2,5],[1,4],[5,3],[1,6],[4,2],[3,6],[5,1],[3,4],[6,2]]
      when 7
        return [[1,4],[2,5],[3,6],[7,1],[5,4],[2,3],[6,7],[5,1],[4,3],[6,2],[5,7],[3,1],[4,6],[7,2],[3,5],[1,6],[2,4],[7,3],[6,5],[1,2],[4,7]]
      when 8
        return [[2,3],[1,5],[7,4],[6,8],[1,2],[3,4],[5,6],[8,7],[4,1],[5,2],[8,3],[6,7],[4,2],[8,1],[7,5],[3,6],[2,8],[5,4],[6,1],[3,7],[4,8],[2,6],[3,5],[1,7],[4,6],[8,5],[7,2],[1,3]]
      end
  end

end

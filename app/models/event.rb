require 'securerandom'

class Event < ActiveRecord::Base

  belongs_to :team
  has_many :participants
  has_many :students, through: :participants

  before_validation :create_key

  def create_key
    self.secret_key ||= SecureRandom.base64(9).gsub(/[^a-zA-z\d]/, Random.rand(9).to_s)
  end

end

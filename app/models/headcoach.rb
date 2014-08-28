class Headcoach < ActiveRecord::Base
  has_many :teams
  devise :database_authenticatable, :registerable, :recoverable, :timeoutable
  validates_presence_of :name, :email, :password, :password_confirmation
  
end

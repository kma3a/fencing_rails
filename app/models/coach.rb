class Coach < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :team_coaches
  has_many :teams, through: :team_coaches
  has_many :owned_teams, class_name: "Team", foreign_key: 'headcoach_id'

  validates_presence_of :name
  private

  def sign_in
    default_params.permit(:name, :email)
  end
end

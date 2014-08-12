class Coach < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :team_coaches
  has_many :teams, through: :team_coaches

  def sign_in
    default_params.permit(:name, :email)
  end
end

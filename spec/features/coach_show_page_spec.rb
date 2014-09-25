require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "coach show page" do
  let(:headcoach) {Headcoach.create({name:"Joe", email: "JoeJ@gmail.com", password: "Jokye", password_confirmation: "Jokye"})}
  let(:coach) {Coach.create({name: "Mark", email: "Mark@amelia.com", password: "Markymark", password_confirmation: "Markymark"})}
  let(:team) {Team.new({name: "Amelia", headcoach_id: headcoach.id})}
  
  before{login_as(coach, scope: :coach)}
  before{coach.teams << team}

  scenario "coach should display the teams" do
    visit(coach_path(coach))
    expect(page).to have_content("Amelia")
  end

  scenario "coach page should display the name" do
    visit(coach_path(coach))
    expect(page).to have_content("Mark")
  end

  scenario "coach page should link to team page" do
    visit(coach_path(coach))
    click_link("Amelia")
    expect(current_path).to eq(team_path(team))
  end

end

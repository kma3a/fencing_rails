require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "coach show page" do
  let(:headcoach) {Coach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:coach) {Coach.create({name: "Mark", email: "Mark@amelia.com", password: "Markymark", password_confirmation: "Markymark"})}
  let(:team) {Team.new({name: "Amelia", headcoach_id: headcoach.id})}
  
  before{coach.teams << team}
  before{login_as(coach, scope: :coach)}

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

  scenario "if you are on another page can click profile and get the show page" do
    visit(team_path(team))
    click_link("Profile")
    expect(current_path).to eq(coach_path(coach))
  end

  scenario "click edit to get to the edit profile" do
    visit(coach_path(coach))
    click_link("Edit")
    expect(current_path).to eq(edit_coach_registration_path(coach))
  end

end

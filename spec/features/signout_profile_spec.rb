require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "coach signout and profile link tests" do

  scenario "signout don't apear until when headcoach isn't signed in" do
    visit("/")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "profile don't appear when headcoach isn't signed in" do
    visit("/")
    expect(page).to_not have_content("Profile")
  end
    

  let(:headcoach) {Coach.create({name:"matt", email: 'vanillabear@otter.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:student) {Student.create({name: "poo"})}
  let(:team) {Team.create({name: "pooy otters", headcoach_id: headcoach.id})}

  before{team.students << student}

  scenario "sign out appears when signed in" do
    login_as(headcoach, scope: :coach)
    visit(coach_path(headcoach))
    expect(page).to have_content("Sign Out")
  end

  scenario "profile appears when signed in" do
    login_as(headcoach, scope: :coach)
    visit(coach_path(headcoach))
    expect(page).to have_content("Profile")
  end

  scenario "when clicked signout will sign out the headcoach" do
    login_as(headcoach, scope: :coach)
    visit(coach_path(headcoach))
    click_link("Sign Out")
    expect(current_path).to eq("/")
  end

  scenario "profile when clicked takes you back to the headcoach's profile" do
    login_as(headcoach, scope: :coach)
    visit(student_path(student.secret_key))
    click_link("Profile")
    expect(current_path).to eq(coach_path(headcoach))
  end


end

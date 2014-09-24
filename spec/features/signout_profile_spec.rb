require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "headcoach signout and profile link tests" do

  scenario "signout don't apear until when headcoach isn't signed in" do
    visit("/")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "profile don't appear when headcoach isn't signed in" do
    visit("/")
    expect(page).to_not have_content("Profile")
  end
    

  let(:headcoach) {Headcoach.create({name:"matt", email: 'vanillabear@otter.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:student) {Student.create({name: "poo"})}
  let(:team) {Team.create({name: "pooy otters", headcoach_id: headcoach.id})}

  before{team.students << student}

  scenario "sign out appears when signed in" do
    login_as(headcoach, scope: :headcoach)
    visit(headcoach_path(headcoach))
    expect(page).to have_content("Sign Out")
  end

  scenario "profile appears when signed in" do
    login_as(headcoach, scope: :headcoach)
    visit(headcoach_path(headcoach))
    expect(page).to have_content("Profile")
  end

end

require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Headcoach show page" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}

    before{login_as(headcoach, scope: :headcoach)}
    before{headcoach.teams << team}

  scenario "can click in link new team" do

    visit(headcoach_path(headcoach.id))
    click_link "Create Team"
    expect(current_path).to eq(new_team_path)

  end

  scenario "click on the edit button and it will render edit" do
    visit(headcoach_path(headcoach.id))
    expect(page).to have_content("Your Teams")
    click_link "Edit"
    expect(current_path).to eq(edit_team_path(team.id))
  end

  scenario "check to see that the delete button works" do
    visit(headcoach_path(headcoach.id))
    click_link "Delete"
    expect(page).to have_no_content("Otters")
  end

  scenario "Check to see that you can click on teamname it will take you to the team show page" do
    visit(headcoach_path(headcoach.id))
    click_link "#{team.name}"
    expect(current_path).to eq(team_path(team.id))
  end

  scenario "click profile to go back to the show page" do
    visit(team_path(team))
    click_link("Profile")
    expect(current_path).to eq(headcoach_path(headcoach))
  end

  scenario "click edit your profile to go to the edit profile page" do
    visit(headcoach_path(headcoach))
    click_link("Edit Your Profile")
    expect(current_path).to eq(edit_headcoach_registration_path(headcoach))
  end
end

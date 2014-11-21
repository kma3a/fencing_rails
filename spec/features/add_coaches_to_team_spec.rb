require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Add Coaches to Team page" do
    
    let(:headcoach) {Coach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:coach) {Coach.create({name: "Tory", email: 'tory@otters.com', password: 'docotter', password_confirmation: 'docotter'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}

    before{login_as(headcoach, scope: :coach)}
    before{headcoach.teams << team}
  
  scenario "can get to the add coaches page" do
    
    visit(team_path(team.id))
    fill_in('coach[email]', with: coach.email)
    click_button "Add Coach"
    expect(page).to_not have_content("Edit Otters")
  end

  scenario "will have coaches on the show page for teams" do
    visit(team_path(team.id))
    fill_in('coach[email]', with: coach.email)
    click_button "Add Coach"
    expect(page).to have_content("Tory")
  end


  scenario "will redirect if not a coach" do
    visit(team_path(team.id))
    fill_in('coach[email]', with: "poopy@otter.com")
    click_button "Add Coach"
    expect(page).to have_content("Coach not found")
  end



end

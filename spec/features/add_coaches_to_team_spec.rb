require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Add Coaches to Team page" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}

    before{login_as(headcoach, scope: :headcoach)}
    before{headcoach.teams << team}
  
  scenario "can get to the add coaches page" do
    
    visit(edit_team_path(team.id))
    fill_in('coach[email]', with: "tory@otter.com")
    click_button "Add Coach"
    expect(current_path).to eq("/teams/#{team.id}/add_coach")
  end

  scenario "will redirect if not a coach" do
    visit(edit_team_path(team.id))
    fill_in('coach[email]', with: "poopy@otter.com")
    click_button "Add Coach"
    expect(page).to have_content("Edit Otters")
  end



end

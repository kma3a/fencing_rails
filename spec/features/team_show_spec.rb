require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "team show page" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}

    before{login_as(headcoach, scope: :headcoach)}
    before{headcoach.teams << team}
  scenario "will show the team name" do
    visit(team_path(team.id))
    expect(page).to have_content("Otters")
  end

end
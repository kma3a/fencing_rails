require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Remove Coaches to Team page" do
    
    let(:headcoach) {Coach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:coach) {Coach.create({name: "Tory", email: 'tory@otters.com', password: 'docotter', password_confirmation: 'docotter'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}
    before{team.coaches << coach}
    before{login_as(headcoach, scope: :coach)}
  
  scenario "removes name from list" do 
    visit(team_path(team.id))
    click_link("Remove")
    expect(page).to_not have_content("Tory")
  end

end

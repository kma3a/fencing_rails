require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Remove Students to Team page" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:coach) {Coach.create({name: "Tory", email: 'tory@otters.com', password: 'docotter', password_confirmation: 'docotter'})}
    let(:student) {Student.create({name: "Tony"})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}

    before{login_as(headcoach, scope: :headcoach)}
    before{headcoach.teams << team}
    before{team.students << student}
    before{team.coaches << coach}
  
  scenario "removes name from list" do 
    visit(team_path(team.id))
    click_link("Remove Student")
    expect(page).to_not have_content("Tony")
  end

end

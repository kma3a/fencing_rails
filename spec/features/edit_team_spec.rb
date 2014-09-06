require "rails_helper"

include Warden::Test::Helpers
Warden.test_mode!

feature "edit team" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}

    before{login_as(headcoach, scope: :headcoach)}
    before{ headcoach.teams << team}

  scenario "allows team to be edited with valid input" do
    visit(edit_team_path(team.id))
    fill_in('team[name]', with: "Fighting Otters")
    click_button "Submit"
    expect(current_path).to eq(headcoach_path(headcoach.id))
  end

  scenario "allows team to be edited with valid input" do
    visit(edit_team_path(team.id))
    fill_in('team[name]', with: "Fighting Otters")
    click_button "Submit"
    expect(page).to have_content("Fighting Otters")
  end

end



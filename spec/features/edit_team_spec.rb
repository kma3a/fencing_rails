require "rails_helper"

include Warden::Test::Helpers
Warden.test_mode!

feature "edit team" do
    
    let(:headcoach) {Coach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}

    before{login_as(headcoach, scope: :coach)}
    before{ headcoach.teams << team}

  scenario "allows team to be edited with valid input" do
    visit(edit_team_path(team.id))
    fill_in('team[name]', with: "Fighting Otters")
    click_button "Submit"
    expect(current_path).to eq(coach_path(headcoach.id))
  end

  scenario "allows team to be edited with valid input" do
    visit(edit_team_path(team.id))
    fill_in('team[name]', with: "Fighting Otters")
    click_button "Submit"
    expect(page).to have_content("Fighting Otters")
  end


  scenario "will not redirect if not valid input" do
    visit(edit_team_path(team.id))
    fill_in('team[name]', with: "")
    click_button "Submit"
    expect(current_path).to eq("/teams/#{team.id}")
  end

end



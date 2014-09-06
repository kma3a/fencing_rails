require "rails_helper"

include Warden::Test::Helpers
Warden.test_mode!

feature "creat new team" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

    before{login_as(headcoach, scope: :headcoach)}

  scenario "a headcoach can create a new team" do
  
    visit('/teams/new')

    fill_in('team[name]', with: "Fighting Otters")

    expect{ click_button "Submit"}.to change(Team, :count).by(1)
  end

  scenario "will redirect after creating team" do
  
    visit('/teams/new')

    fill_in('team[name]', with: "Fighting Otters")
    click_button "Submit"
    expect(current_path).to eq(headcoach_path(headcoach.id))
  end

  scenario "Will have the name of the new team on the page" do
  
    visit('/teams/new')

    fill_in('team[name]', with: "Fighting Otters")
    click_button "Submit"
    expect(page).to have_content("Fighting Otters")
  end

  scenario "will not save if invalid" do
  
    visit('/teams/new')

    fill_in('team[name]', with: "")

    expect{ click_button "Submit"}.to change(Team, :count).by(0)
  end

  scenario "will not save if invalid" do
  
    visit('/teams/new')

    fill_in('team[name]', with: "")
    click_button "Submit"
    expect(current_path).to eq("/teams")
  end

end

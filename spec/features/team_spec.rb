require "rails_helper"

include Warden::Test::Helpers
Warden.test_mode!

feature "creat new team" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

    before{login_as(headcoach, scope: :headcoach)}

  scenario "a headcoach can create a new team" do
  
    visit('/teams/new')

#   expect(page).to have_content("hi")

    fill_in('team[name]', with: "Fighting Otters")

    expect{ click_button "Submit"}.to change(Team, :count).by(1)
  end
end

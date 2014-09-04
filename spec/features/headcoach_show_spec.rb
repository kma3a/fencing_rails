require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Headcoach show page" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

    before{login_as(headcoach, scope: :headcoach)}

  scenario "can click in link new team" do

    visit(headcoach_path(headcoach.id))
    click_link "Create Team"
    expect(current_path).to eq(new_team_path)

  end

end

require "rails_helper"

feature "welcome page tests" do

  scenario "will go to welcome page" do
    visit("/")
    expect(page).to have_content("Welcome to Fencing!")
  end

  scenario "When click on headcoach link will go to login page" do
    visit("/")
    click_link("Head Coach Sign In")
    expect(current_path).to eq(new_headcoach_session_path)
  end

  scenario "When click on coach link will go to login page" do
    visit("/")
    click_link("Coach Sign In")
    expect(current_path).to eq(new_coach_session_path)
  end

end

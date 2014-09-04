require "rails_helper"

feature "welcome page tests" do

  scenario "will go to welcome page" do
    visit("/")
    expect(page).to have_content("Welcome to Fencing!")
  end
end

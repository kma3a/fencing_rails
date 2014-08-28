require 'rails_helper'

feature 'headcoach sign up' do
  scenario "a person can sign up as a headcoach" do

    visit('/headcoaches/sign_up')

    fill_in("Name", with: "Coach P")
    fill_in("Email", with: "coachp@gmail.com")
    fill_in("Password", with: "chesterknights")

    expect{ click_button "Sign up"}.to change(Headcoach, :count).by(1)

  end
end

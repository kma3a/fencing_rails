require 'rails_helper'

feature 'coach sign up' do
  scenario 'signs up coach with valid input' do
    visit('/coaches/sign_up')

    fill_in("Name", with: "Coach Mark")
    fill_in("Email", with: "mark@gmail.com")
    fill_in("Password", with: "ameliasteal")
    fill_in("Password confirmation", with: "ameliasteal")

    expect{ click_button "Sign up"}.to change(Coach, :count).by(1)
  end

end

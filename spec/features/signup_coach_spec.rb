require 'rails_helper'

feature 'coach sign up' do
  scenario 'signs up coach with valid input' do
    visit('/coaches/sign_up')

    fill_in("Name", with: "Coach Mark")
    fill_in("Email", with: "mark@gmail.com")
    fill_in("Password", with: "ameliasteal")
    fill_in("Confirm Password", with: "ameliasteal")

    expect{ click_button "Sign up"}.to change(Coach, :count).by(1)
  end
  

  scenario 'does not sign up coach with invalid input' do
    visit('/coaches/sign_up')

    fill_in("Name", with: "")
    fill_in("Email", with: "mark@gmail.com")
    fill_in("Password", with: "ameliasteal")
    fill_in("Confirm Password", with: "ameliasteal")

    expect{ click_button "Sign up"}.to change(Coach, :count).by(0)
  end

  scenario 'does not sign up coach with no email' do
    visit('/coaches/sign_up')

    fill_in("Name", with: "Coach Mark")
    fill_in("Email", with: "")
    fill_in("Password", with: "ameliasteal")
    fill_in("Confirm Password", with: "ameliasteal")

    expect{ click_button "Sign up"}.to change(Coach, :count).by(0)
  end

  scenario 'does not sign up coach with no password' do
    visit('/coaches/sign_up')

    fill_in("Name", with: "Coach Mark")
    fill_in("Email", with: "mark@gmail.com")
    fill_in("Password", with: "")
    fill_in("Confirm Password", with: "ameliasteal")

    expect{ click_button "Sign up"}.to change(Coach, :count).by(0)
  end

  scenario 'does not sign up coach with no password confirmation' do
    visit('/coaches/sign_up')

    fill_in("Name", with: "Coach Mark")
    fill_in("Email", with: "mark@gmail.com")
    fill_in("Password", with: "ameliasteal")
    fill_in("Confirm Password", with: "")

    expect{ click_button "Sign up"}.to change(Coach, :count).by(0)
  end

  scenario 'makes sure will redirect if valid' do
    visit('/coaches/sign_up')

    fill_in("Name", with: "Coach Mark")
    fill_in("Email", with: "mark@gmail.com")
    fill_in("Password", with: "ameliasteal")
    fill_in("Confirm Password", with: "ameliasteal")
    click_button "Sign up"

    expect(current_path).to eq(coach_path(Coach.last))
  end

  scenario 'will render same view if not valid' do
    visit('/coaches/sign_up')

    fill_in("Name", with: "Coach Mark")
    fill_in("Email", with: "")
    fill_in("Password", with: "ameliasteal")
    fill_in("Confirm Password", with: "ameliasteal")
    click_button "Sign up"

    expect(current_path).to eq('/coaches')
  end

end

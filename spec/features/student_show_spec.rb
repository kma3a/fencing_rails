require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "student show page" do

  let(:headcoach) {Coach.create({name:"matt", email: 'vanillabear@otter.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:student) {Student.create({name: "poo"})}
  let(:team) {Team.create({name: "pooy otters", headcoach_id: headcoach.id})}

  before{login_as(headcoach, scope: :coach)}
  before{team.students << student}

  scenario "will show the name of the student" do
    visit(student_path(student.secret_key))
    expect(page).to have_content("poo")
  end

  scenario "Will show the teams that they belong to" do
    visit(student_path(student.secret_key))
    expect(page).to have_content("pooy otters")
  end

  scenario "Will show the secret_key for the student" do
    visit(student_path(student.secret_key))
    expect(page).to have_content(student.secret_key)
  end

end

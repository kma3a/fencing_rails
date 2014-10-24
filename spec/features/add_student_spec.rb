require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Add students" do
    
    let(:headcoach) {Coach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:coach) {Coach.create({name: "Tory", email: 'tory@otters.com', password: 'docotter', password_confirmation: 'docotter'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}
    let(:student) {Student.create({name: "Percy"})}

    before{login_as(headcoach, scope: :coach)}
    before{headcoach.teams << team}
  
  scenario "can get to the student create page" do
    visit(coach_path(headcoach.id))
    click_link("Add Student")
    expect(current_path).to eq(new_student_path)
  end

  scenario "the page had new student on it" do
    visit(coach_path(headcoach.id))
    click_link("Add Student")
    expect(page).to have_content("Create A New Student")
  end

  scenario "fill in form" do
    visit(new_student_path)
    fill_in('student[name]', with: 'Percy')
    click_button("Create Student")
    expect(current_path).to eq(student_path(Student.last.secret_key))
  end

  scenario "check that it went to the right page" do
    visit(new_student_path)
    fill_in('student[name]', with: 'Percy')
    click_button("Create Student")
    expect(page).to have_content("Percy's Page")
  end

  scenario "add student to team on team show page" do
    visit(team_path(team))
    fill_in('student[secret_key]', with: student.secret_key)
    click_button("Add Student")
    expect(page). to have_content(student.name)
  end

end

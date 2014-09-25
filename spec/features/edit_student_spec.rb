require "rails_helper"

include Warden::Test::Helpers
Warden.test_mode!

feature "edit student" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}
    let(:student) {Student.create({name: "Ken"})}

    before{login_as(headcoach, scope: :headcoach)}
    before{ headcoach.teams << team}
    before{team.students << student}

    scenario "Student edit button is for headcoaches on team page" do
      visit(team_path(team))
      click_link("Edit Student")
      expect(current_path).to eq(edit_student_path(student.secret_key))
    end

    scenario "Student edit page will have secret key of student" do
      visit(edit_student_path(student.secret_key))
      expect(page).to have_content(student.secret_key)
    end
end


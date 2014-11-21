require "rails_helper"

include Warden::Test::Helpers
Warden.test_mode!

feature "edit student" do
    
    let(:headcoach) {Coach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}
    let(:student) {Student.create({name: "Ken"})}

    before{login_as(headcoach, scope: :coach)}
    before{ headcoach.teams << team}
    before{team.students << student}

    scenario "Student edit button is for headcoaches on team page" do
      visit(team_path(team))
      click_link("Edit")
      expect(current_path).to eq(edit_student_path(student.secret_key))
    end

    scenario "Student edit page will have secret key of student" do
      visit(edit_student_path(student.secret_key))
      expect(page).to have_content(student.secret_key)
    end

    scenario "When filled in correctly goes to student's page" do
      visit(edit_student_path(student.secret_key))
      fill_in('student[name]', with: "Kenny")
      click_button "Create Student"
      expect(current_path).to eq(student_path(student.secret_key))
    end

    scenario "will show student's new name" do
      visit(edit_student_path(student.secret_key))
      fill_in('student[name]', with: "Kenny")
      click_button "Create Student"
      expect(page).to have_content("Kenny")
    end

     scenario "with render edit page if name is invalid" do
      visit(edit_student_path(student.secret_key))
      fill_in('student[name]', with: "")
      click_button "Create Student"
      expect(page).to have_content("Name can't be blank")
    end
     
end


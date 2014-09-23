require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Add students" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:coach) {Coach.create({name: "Tory", email: 'tory@otters.com', password: 'docotter', password_confirmation: 'docotter'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}
    let(:student) {Student.create({name: "Mike Murry"})}

    before{login_as(headcoach, scope: :headcoach)}
    before{headcoach.teams << team}
  
  scenario "can get to the student create page" do
    visit(headcoach_path(headcoach.id))
    click_link("Add Student")
    expect(current_path).to eq(new_student_path)
  end

  scenario "the page had new student on it" do
    visit(headcoach_path(headcoach.id))
    click_link("Add Student")
    expect(page).to have_content("Create A New Student")
  end

end

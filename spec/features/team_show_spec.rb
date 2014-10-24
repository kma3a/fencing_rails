require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "team show page" do
    let(:headcoach) {Coach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}
    let(:student) {Student.create({name: "Josh"})}
    let(:student1) {Student.new({name: "Kelly"})}
    let(:student2) {Student.new({name: "Sara"})}
    let(:student3) {Student.new({name: "Zack"})}
    let(:student4) {Student.new({name: "Ben"})}
    let(:event) {Event.create({event_title: "test pool", team_id: team.id, participant_count: 4})}
    let(:particiapant1) {Participant.create({student_id: studnet1.id, event_id: event.idi, bout_number: 1})}
    let(:particiapant2) {Participant.create({student_id: studnet2.id, event_id: event.idi, bout_number: 2})}
    let(:particiapant3) {Participant.create({student_id: studnet3.id, event_id: event.idi, bout_number: 3})}
    let(:particiapant4) {Participant.create({student_id: studnet4.id, event_id: event.idi, bout_number: 4})}


    before{login_as(headcoach, scope: :coach)}
    before{headcoach.teams << team}
    before{team.students << student}
    before{team.events << event}

  scenario "will show the team name" do
    visit(team_path(team.id))
    expect(page).to have_content("Otters")
  end


  scenario "will show the headcoach name" do
    visit(team_path(team.id))
    expect(page).to have_content("Headcoach: matt")
  end


  scenario 'will show students' do
    visit(team_path(team.id))
    expect(page).to have_content("Josh")
  end

  scenario "will show events" do
    visit(team_path(team.id))
    expect(page).to have_content(event.event_title)
  end

end


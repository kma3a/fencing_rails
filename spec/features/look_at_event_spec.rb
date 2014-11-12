require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "look at events show page" do

    let(:headcoach) {Coach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}
    let(:student1) {Student.create({name: "Kelly"})}
    let(:student2) {Student.create({name: "Sara"})}
    let(:student3) {Student.create({name: "Zack"})}
    let(:student4) {Student.create({name: "Ben"})}
    let(:event) {Event.create({event_title: "test pool", team_id: team.id, participant_count: 4})}
    let(:participant1) {Participant.create({student_id: student1.id, event_id: event.id, bout_number: 1})}
    let(:participant2) {Participant.create({student_id: student2.id, event_id: event.id, bout_number: 2})}
    let(:participant3) {Participant.create({student_id: student3.id, event_id: event.id, bout_number: 3})}
    let(:participant4) {Participant.create({student_id: student4.id, event_id: event.id, bout_number: 4})}

    before{login_as(headcoach, scope: :coach)}
    before{headcoach.teams << team}
    before{team.students << student1}
    before{team.students << student3}
    before{team.students << student4}
    before{team.events << event}
    before{event.participants << participant1}
    before{event.participants << participant2}
    before{event.participants << participant3}
    before{event.participants << participant4}
  it "renders to event if valid" do
    visit(root_path)
    fill_in("event[secret_key]", with: event.secret_key)
    click_button("View Event")
    expect(current_path).to eq("/events")
  end

  it "redirects to home if not valid" do
    visit(root_path)
    fill_in("event[secret_key]", with: "wseljseerlw")
    click_button("View Event")
    expect(current_path).to eq(root_path)

  end

end

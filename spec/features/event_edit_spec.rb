require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Create events" do
    
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

    scenario "On the team page there should be a edit event button" do
      visit(team_path(team))
      click_link("Edit Event")
      expect(current_path).to eq(edit_team_event_path(team, event))
    end

    scenario "On event page there should create event words" do
      visit(team_path(team))
      click_link("Edit Event")
      expect(page).to have_content("Edit Event")
    end

    scenario "fill in form" do
      visit(edit_team_event_path(team, event))
      page.all(:fillable_field, 'event[participants][]')[0].set(student2.secret_key)
      page.all(:fillable_field, 'event[participants][]')[1].set(student3.secret_key)
      page.all(:fillable_field, 'event[participants][]')[2].set(student1.secret_key)
      page.all(:fillable_field, 'event[participants][]')[3].set(student4.secret_key)
      click_button("Update Event")
      expect(current_path).to eq(team_event_path(team, event))
    end
    
    scenario "expect participants to change" do
      visit(edit_team_event_path(team, event))
      page.all(:fillable_field, 'event[participants][]')[0].set(student2.secret_key)
      page.all(:fillable_field, 'event[participants][]')[1].set(student3.secret_key)
      page.all(:fillable_field, 'event[participants][]')[2].set(student1.secret_key)
      page.all(:fillable_field, 'event[participants][]')[3].set(student4.secret_key)
      click_button("Update Event")
      expect(event.participants.first.student_id).to eq(student2.id)
      expect(event.participants.where(student_id: student3.id).first.bout_number).to eq(2)
    end

end

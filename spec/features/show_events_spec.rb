require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "event show page" do

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

    it 'shows the students' do
      visit(team_event_path(team, event))
      expect(page).to have_content(student1.name)
      expect(page).to have_content(student2.name)
      expect(page).to have_content(student3.name)
      expect(page).to have_content(student4.name)
    end

    it 'shows the bouts and can click on them' do
      visit(team_event_path(team, event))
      expect(page).to have_content("1 vs 4")
    end

    it 'should be clickable' do
      visit(team_event_path(team, event))
      click_link("1 vs 4")
      expect(current_path).to eq(bout_path(event, participant1.bout_number, participant4.bout_number))
    end

    it 'should change the events page when updated' do
      visit(bout_path(event, participant1.bout_number, participant4.bout_number))
      fill_in("participant1[bout_points]", with: 5)
      fill_in("participant2[bout_points]", with: 3)
      page.find(:css, '#victory_1').set(true)
      click_button('Submit')
      expect(page).to have_content("V5")
      expect(page).to have_content("D3")
    end



end

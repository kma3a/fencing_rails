require 'rails_helper'

describe Participant do
  it { should belong_to(:event)}
  it { should belong_to(:student)}
  let(:headcoach) {Headcoach.create({name: "Mark", email: "marrt@lsejrle.com", password: "beavers", password_confirmation: "beavers"})}
  let(:team) {Team.create({name:"Otters", headcoach_id: headcoach.id})}
  let(:event) {Event.create({event_title: "10/14/14", team_id: team.id, participant_count: 5})}
  let(:student) {Student.create({name: "Joe"})}
  let(:participant) {Participant.create({event_id: event.id, student_id: student.id, bout_number: 1})}
  let(:participant2) {Participant.create({event_id: event.id, student_id: student.id, bout_number: 2})}
  it ' should fill in bout_results' do
    expect(participant.bout_results).to_not eq(nil)
    expect(participant.bout_results).to eq({2=> 0, 3=> 0, 4=> 0, 5=> 0}) 
  end
  it 'should update the bout_results' do
    participant.change_results(2,"V5")
    expect(participant.bout_results).to eq({2=> "V5", 3=> 0, 4=> 0, 5=>0})
  end
  it 'should have method to get the victories' do
    participant.change_results(2,"V5")
    expect(participant.victories).to eq(1)
  end
end

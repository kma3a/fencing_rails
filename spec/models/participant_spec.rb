require 'rails_helper'

describe Participant do
  it { should belong_to(:event)}
  it { should belong_to(:student)}
  let(:headcoach) {Coach.create({name: "Mark", email: "marrt@lsejrle.com", password: "beavers", password_confirmation: "beavers"})}
  let(:team) {Team.create({name:"Otters", headcoach_id: headcoach.id})}
  let(:event) {Event.create({event_title: "10/14/14", team_id: team.id, participant_count: 5})}
  let(:student) {Student.create({name: "Joe"})}
  let(:student1) {Student.create({name: "Jamie"})}
  let(:student3) {Student.create({name: "Jess"})}
  let(:student4) {Student.create({name: "Dan"})}
  let(:student2) {Student.create({name: "Mike"})}
  let(:participant) {Participant.create({event_id: event.id, student_id: student.id, bout_number: 1})}
  let(:participant2) {Participant.create({event_id: event.id, student_id: student2.id, bout_number: 2})}
  let(:participant1) {Participant.create({event_id: event.id, student_id: student1.id, bout_number: 4})}
  let(:participant3) {Participant.create({event_id: event.id, student_id: student3.id, bout_number: 3})}
  let(:participant4) {Participant.create({event_id: event.id, student_id: student4.id, bout_number: 5})}
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
  it 'should update the touches_scored' do
    participant.change_results(2,"V5")
    expect(participant.touches_scored).to eq(5)
  end
  it ' should update touches_recieved for opponient' do
    participant.change_results(2,"V5")
    participant2.update_tr
    expect(participant2.touches_recieved).to eq(5)
  end
  it ' should calculate the indicator' do
    participant.change_results(2,"V5")
    participant2.change_results(1,"D3")
    participant.update_tr
    participant.calc_indicator
    expect(participant.indicator).to eq(2)
  end
end

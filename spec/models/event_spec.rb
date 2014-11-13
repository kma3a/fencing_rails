require 'rails_helper'

describe Event do

  let(:coach) {Coach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:team) {Team.create({name: "Otters", headcoach_id: coach.id})}
    let(:student1) {Student.create({name: "Kelly"})}
    let(:student2) {Student.create({name: "Sara"})}
    let(:student3) {Student.create({name: "Zack"})}
    let(:student4) {Student.create({name: "Ben"})}

  it { should belong_to(:team)}
  it { should have_many(:participants)}
  it { should have_many(:students).through(:participants)}
  let(:headcoach) {Coach.create({name: "Mark", email: "marrt@lsejrle.com", password: "beavers", password_confirmation: "beavers"})}
  let(:team) {Team.create({name:"Otters", headcoach_id: headcoach.id})}
  let(:event) {Event.create({event_title: "10/14/14", team_id: team.id, participant_count: 5})}
  it 'should give a event a secret key' do
    expect(event.secret_key).to_not eq(nil)
  end
  it 'should return array for a pool of 5' do
    expect(event.get_pool).to eq([[1,2],[3,4],[5,1],[2,3],[5,4],[1,3],[2,5],[4,1],[3,5],[4,2]])
  end
  it 'should return array of students' do
    expect(event.get_participants([student1.secret_key, student2.secret_key, student3.secret_key, student4.secret_key])).to eq([student1,student2,student3,student4])
  end
  it "should return error if array invalid" do
    expect(event.get_participants([student1.secret_key, student2.secret_key, "skdejrlewer", student4.secret_key])).to eq("Error")
  end
end

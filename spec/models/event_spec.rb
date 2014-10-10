require 'rails_helper'

describe Event do
  it { should belong_to(:team)}
  it { should have_many(:participants)}
  it { should have_many(:students).through(:participants)}
  let(:headcoach) {Headcoach.create({name: "Mark", email: "marrt@lsejrle.com", password: "beavers", password_confirmation: "beavers"})}
  let(:team) {Team.create({name:"Otters", headcoach_id: headcoach.id})}
  let(:event) {Event.create({event_title: "10/14/14", team_id: team.id})}
  it 'should give a event a secret key' do
    expect(event.secret_key).to_not eq(nil)
  end
end

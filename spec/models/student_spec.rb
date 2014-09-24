require 'rails_helper'

describe Student do
  it { should have_many(:team_students)}
  it { should have_many(:teams).through(:team_students)}
  it { should have_many(:participants)}
  it { should have_many(:events).through(:participants)}
  it { should validate_presence_of(:name)}
  let(:student) {Student.create({name: "Joe"})}
  it ' should give a student a secret key' do
    expect(student.secret_key).to_not eq(nil) 
  end

end

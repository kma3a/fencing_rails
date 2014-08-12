require 'rails_helper'

describe Student do
  it { should have_many(:team_students)}
  it { should have_many(:teams).through(:team_students)}
  it { should have_many(:participants)}
  it { should have_many(:events).through(:participants)}
end

require 'rails_helper'

describe Team do
  it { should belong_to(:headcoach)}
  it { should have_many(:team_coaches)}
  it { should have_many(:coaches).through(:team_coaches)}
  it { should have_many(:team_students)}
  it { should have_many(:students).through(:team_students)}
  it { should have_many(:events)}
  it { should validate_presence_of(:name)}
end

require 'rails_helper'

describe Coach do
  it { should have_many(:team_coaches)}
  it { should have_many(:teams).through(:team_coaches)}  
end

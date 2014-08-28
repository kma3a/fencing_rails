require 'rails_helper'

describe Headcoach do
  it { should have_many(:teams)}
  it { should validate_presence_of(:name)}
end

require 'rails_helper'

describe Event do
  it { should belong_to(:team)}
  it { should have_many(:participants)}
  it { should have_many(:students).through(:participants)}
end

require 'rails_helper'

describe Headcoach do
  it { should have_many(:teams)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:password_confirmation)}
end

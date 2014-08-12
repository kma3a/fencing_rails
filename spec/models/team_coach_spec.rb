require 'rails_helper'

describe TeamCoach do
  it { should belong_to(:team)}
  it { should belong_to(:coach)}
end

require 'rails_helper'

describe TeamStudent do
  it { should belong_to(:team)}
  it { should belong_to(:student)}
end

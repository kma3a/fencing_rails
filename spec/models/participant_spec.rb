require 'rails_helper'

describe Participant do
  it { should belong_to(:event)}
  it { should belong_to(:student)}
end

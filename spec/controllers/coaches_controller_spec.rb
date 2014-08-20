require 'rails_helper'

describe CoachesController do
  before(:each) do
    
  end

  describe '#show' do
    it 'renders a post' do
      coach = double(:coach)
      Coach.should_receive(:find).with("1").and_return(coach)
      get :show, :id => "1"
      expect(assigns(:user)).to eq coach
    end
  end
end

require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

  before {sign_in headcoach}
  describe 'POST #create' do

    it "should create a team" do
      expect{ post :create, team: {name: 'Fighting Otters', headcoah_id: 1} }.to change(Team,:count).by(1)
    end
  end

 end




require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

  before {sign_in headcoach}
  describe 'POST #create' do
    subject {post :create, team: {name: 'Fighting Otters', headcoah_id: 1} }
    context 'valid attributes' do
      it "should create a team" do
        expect{subject}.to change(Team,:count).by(1)
      end

      it 'redirects to the new contact' do
        expect(subject).to redirect_to("/headcoaches/#{assigns(:team).headcoach.id}")
      end
    end
  end

  describe 'GET #new' do
  end


 end




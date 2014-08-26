require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

  before {sign_in headcoach}
  describe 'POST #create' do
    context 'valid attributes' do
    subject {post :create, team: {name: 'Fighting Otters', headcoah_id: 1} }
      it "should create a team" do
        expect{subject}.to change(Team,:count).by(1)
      end

      it 'redirects to the new contact' do
        expect(subject).to redirect_to("/headcoaches/#{assigns(:team).headcoach.id}")
      end
    end

    context 'invalid attributes' do
    subject {post :create, team: {name: nil, headcoach_id: 1}}

      it ' should not save the new team' do
        expect{subject}.to_not change(Team,:count)
      end

      it 're-render new' do
        expect(subject).to render_template("teams/new")
      end
    end
  end
  
  describe 'PUt update' do
    before :each do
      @team = Team.create!({name:"Otters", headcoach_id: 1})
    end

    context 'valit attribute' do
      subject {put :update, id: @team, team:{name:"Otters", headcoach_id: 1}}
    end

  end

  describe 'GET #new' do
    it 'located requested @team' do
      get 'new'
      assigns(:team).should be_a_kind_of(Team)
    end

    it 'should be a new record' do
      get 'new'
      assigns(:team).should be_new_record
    end
   end


 end




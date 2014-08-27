require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

  before {sign_in headcoach}
  describe 'POST #create' do
    context 'valid attributes' do
    subject {post :create, team: {name: 'Fighting Otters', headcoah_id: headcoach.id} }
      it "should create a team" do
        expect{subject}.to change(Team,:count).by(1)
      end

      it 'redirects to the new contact' do
        expect(subject).to redirect_to("/headcoaches/#{assigns(:team).headcoach.id}")
      end
    end

    context 'invalid attributes' do
    subject {post :create, team: {name: nil, headcoach_id: headcoach.id}}

      it ' should not save the new team' do
        expect{subject}.to_not change(Team,:count)
      end

      it 're-render new' do
        expect(subject).to render_template("teams/new")
      end
    end
  end
  
  describe 'GET #edit' do
    let(:team) {Team.create({name:"Otters", headcoach_id: headcoach.id})}
    before(:each) { get :edit, id: team.id}

    it 'should assign @team' do
      expect(assigns(:team)).to eq(team)
    end

    it 'renders the #edit view' do
      expect(response).to render_template(:edit)
    end

  end

  describe 'GET #new' do
    it 'located requested @team' do
      get 'new'
      expect(assigns(:team)).to be_a_kind_of(Team)
    end

    it 'should be a new record' do
      get 'new'
      expect(assigns(:team)).to be_a_new(Team)
    end
   end

   describe 'PUT #update' do
    before(:each) {@team = Team.create({name:"Otters", headcoach_id: headcoach.id})}
     before(:each) { put :update, id: @team.id, team: {name:"Otters", headcoach_id: headcoach.id}}

    it 'should assign @team' do
      expect(assigns(:team)).to eq(@team)
    end

   end

   describe 'DELETE destroy' do
    before(:each) {@team = Team.create({name:"Otters", headcoach_id: headcoach.id})}
    before(:each) { delete :destroy, {:id => @team.id}}

    it 'should assign @team' do
      expect(assigns(:team)).to eq(@team)
    end

    it 'delete the contact' do
      @team = Team.create({name:"Otters", headcoach_id: headcoach.id})
      expect{delete :destroy, {:id => @team.id}}.to change{Team.count}.by(-1)
    end

    it 'should render headcoach' do
      expect(response).to redirect_to("/headcoaches/#{assigns(:team).headcoach_id}")
    end

   end


 end




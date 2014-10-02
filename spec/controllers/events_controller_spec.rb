require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:team) {Team.create({name: "Otters"})}

  before {sign_in headcoach}

  describe "GET #new" do
    it " locate the @event" do
      get 'new'
      expect(assigns(:event)).to be_a_kind_of(Event)
    end

    it "should be a new record" do
      get 'new'
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe "POST #create" do
    context "valid attributes" do
      subject {post :create, event: {event_title: "10/02/14", team_id: team, participant_count: 4}}
      it "should create a team" do
        expect{subject}.to change(Team, :count).by(1)
      end

      it "redirects to the event show page" do
        expect(subject).to redirect_to(event_path(Event.last))
      end
    end  
  end

end

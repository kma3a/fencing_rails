require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:team) {Team.create({name: "Otters"})}
    let(:student1) {Student.new({name: "Kelly"})}
    let(:student2) {Student.new({name: "Sara"})}
    let(:student3) {Student.new({name: "Zack"})}
    let(:student4) {Student.new({name: "Ben"})}


  before {sign_in headcoach}

  describe "GET #new" do
    it " locate the @event" do
      get 'new', {team_id: team.id}
      expect(assigns(:event)).to be_a_kind_of(Event)
    end

    it "should be a new record" do
      get 'new', {team_id: team.id}
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe "POST #create" do
    context "valid attributes" do
      subject {post :create, team_id: team.id, event: {event_title: "10/02/14", team_id: team, participants: [student1.secret_key, student2.secret_key, student3.secret_key, student4.secret_key]}}
      it "should create a event" do
        expect{subject}.to change(Event, :count).by(1)
      end

      it "redirects to the event show page" do
        expect(subject).to redirect_to(team_event_path(team, Event.last))
      end
    end  
  end

end

require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  let(:coach) {Coach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:team) {Team.create({name: "Otters", headcoach_id: coach.id})}
    let(:student1) {Student.new({name: "Kelly"})}
    let(:student2) {Student.new({name: "Sara"})}
    let(:student3) {Student.new({name: "Zack"})}
    let(:student4) {Student.new({name: "Ben"})}


  before {sign_in coach}

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

  describe 'GET #edit' do
    let(:event) {Event.create({event_title: "test pool", team_id: team.id, participant_count: 4})}
    let(:participant1) {Participant.create({student_id: student1.id, event_id: event.id, bout_number: 1})}
    let(:participant2) {Participant.create({student_id: student2.id, event_id: event.id, bout_number: 2})}
    let(:participant3) {Participant.create({student_id: student3.id, event_id: event.id, bout_number: 3})}
    let(:participant4) {Participant.create({student_id: student4.id, event_id: event.id, bout_number: 4})}
    before(:each) {get :edit, id: event.id, team_id: team.id}
    before(:each) {event.participants << participant1}
    before(:each) {event.participants << participant2}
    before(:each) {event.participants << participant3}
    before(:each) {event.participants << participant4}

    it 'should assign the requested event' do
      expect(assigns(:event)).to eq(event)
    end
    
    it 'should render edit view' do
      expect(response).to render_template(:edit)
    end

  end

  describe 'PUT #update' do
    let(:event) {Event.create({event_title: "test pool", team_id: team.id, participant_count: 4})}
    let(:studentnew) {Student.create({name: "Joe"})}
    let(:participant1) {Participant.create({student_id: student1.id, event_id: event.id, bout_number: 1})}
    let(:participant2) {Participant.create({student_id: student2.id, event_id: event.id, bout_number: 2})}
    let(:participant3) {Participant.create({student_id: student3.id, event_id: event.id, bout_number: 3})}
    let(:participant4) {Participant.create({student_id: student4.id, event_id: event.id, bout_number: 4})}
    before(:each) {event.participants << participant1}
    before(:each) {event.participants << participant2}
    before(:each) {event.participants << participant3}
    before(:each) {event.participants << participant4}
    it 'should assign @event' do
      put :update, id: event.id, team_id: team.id, event: {event_title: "Test Pool", participants: [studentnew.secret_key, student2.secret_key, student3.secret_key, student4.secret_key]}
      expect(assigns(:event)).to eq(event)
    end

   it 'changes event attributes' do
      put :update, id: event.id, team_id: team.id, event: {event_title: "Test Pool", participants: [studentnew.secret_key, student2.secret_key, student3.secret_key, student4.secret_key]}
      event.reload
      expect(event.participants.first.student).to eq(studentnew)
    end

   it 'redirects to the show page' do
      put :update, id: event.id, team_id: team.id, event: {event_title: "Test Pool", participants: [studentnew.secret_key, student2.secret_key, student3.secret_key, student4.secret_key]}
      expect(response).to redirect_to(team_event_path(team, event))
    end


  end

end

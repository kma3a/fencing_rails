require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do
  let(:coach) {Coach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

  before {sign_in coach}

  describe 'GET #show' do
     let(:team) {Team.create({name:"Otters", headcoach_id: coach.id})}
    before(:each) { get :show, id: team.id}
    it 'assigns the requested team' do
      expect(assigns(:team)).to eq(team)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
    subject {post :create, team: {name: 'Fighting Otters', headcoach_id: coach.id} }
      it "should create a team" do
        expect{subject}.to change(Team,:count).by(1)
      end

      it 'redirects to the new contact' do
        expect(subject).to redirect_to("/coaches/#{assigns(:team).headcoach_id}")
      end
    end

    context 'invalid attributes' do
    subject {post :create, team: {name: nil, headcoach_id: coach.id}}

      it ' should not save the new team' do
        expect{subject}.to_not change(Team,:count)
      end

      it 're-render new' do
        expect(subject).to render_template("teams/new")
      end
    end
  end
  
  describe 'GET #edit' do
    let(:team) {Team.create({name:"Otters", headcoach_id: coach.id})}
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
     before(:each) {@team = Team.create({name:"Otters", headcoach_id: coach.id})}
     context 'valid attributes' do
  
       it 'should assign @team' do
         put :update, id: @team.id, team: {name:"Otters", headcoach_id: coach.id}
         expect(assigns(:team)).to eq(@team)
       end

       it "changes @team's attributes" do
        put :update, id: @team.id, team: {name:"Fighting Otters", headcoach_id: coach.id}
        @team.reload
        expect(@team.name).to eq("Fighting Otters")
       end

       it 'redirects to the headcoach page' do
        put :update, id: @team.id, team: {name:"Fighting Otters", headcoach_id: coach.id}
        expect(response).to redirect_to("/coaches/#{assigns(:team).headcoach_id}")
       end
     end

     context 'invalid attributes' do

      it 'does not change @team attributes' do
        put :update, id: @team, team: {name: "", headcoach_id: coach.id}
        @team.reload
        expect(@team.name).to eq("Otters")
      end

      it 're-renders the edit method' do
        put :update, id: @team, team: {name: "", headcoach_id: coach.id}
        expect(response).to render_template(:edit)
      end
    end

   end

   describe 'DELETE destroy' do
    before(:each) {@team = Team.create({name:"Otters", headcoach_id: coach.id})}
    before(:each) { delete :destroy, {:id => @team.id}}

    it 'should assign @team' do
      expect(assigns(:team)).to eq(@team)
    end

    it 'delete the contact' do
      @team = Team.create({name:"Otters", headcoach_id: coach.id})
      expect{delete :destroy, {:id => @team.id}}.to change{Team.count}.by(-1)
    end

    it 'should render coach' do
      expect(response).to redirect_to("/coaches/#{assigns(:team).headcoach_id}")
    end

   end


  describe 'POST #add_coach' do
    before(:each) {@team = Team.create({name:"Otters", headcoach_id: coach.id})}
    before(:each) {@coach = Coach.create({name:"Tory", email: "tory@otter.com", password: "docotter", password_confirmation: "docotter"})}

    context 'valid attributes' do
      subject {post :add_coach, coach: {email: "tory@otter.com"}, id: @team.id}
      it "should add to team coach count" do
        expect{subject}.to change(@team.coaches,:count).by(1)
      end

      it 'redirects to the new contact' do
        expect(subject).to redirect_to(team_path(@team.id))
      end
    end

    context 'trying to add a coach that is already there' do
      before{@team.coaches << @coach}
      subject {post :add_coach, coach: {email: "tory@otter.com"}, id: @team.id}
      it 'should not add to team coaches count' do
        expect{subject}.to_not change(@team.coaches, :count)
      end

      it 'should re-render edit' do
        expect(subject).to redirect_to(team_path(@team.id))
      end

    end

    context 'invalid attributes' do
      subject {post :add_coach, coach: {email: "y@otter.com"}, id: @team.id}

      it ' should not save the new team' do
        expect{subject}.to_not change(@team.coaches,:count)
      end

      it 're-render edit' do
        expect(subject).to redirect_to(team_path(@team.id))
      end
    end
  end

  describe 'GET #remove_coach' do
    before(:each) {@team = Team.create({name:"Otters", headcoach_id: coach.id})}
    before(:each) {@coach = Coach.create({name:"Tory", email: "tory@otter.com", password: "docotter", password_confirmation: "docotter"})}
    before{@team.coaches << @coach}
      subject {get :remove_coach, id: @team.id, coach_id: @coach.id}
    it 'should take the coach off the team coaches list' do
      expect{subject}.to change(@team.coaches, :count).by(-1)
    end
  end

  describe 'Post #add_student' do
    before(:each) {@team = Team.create({name:"Otters", headcoach_id: coach.id})}
    before(:each) {@coach = Coach.create({name:"Tory", email: "tory@otter.com", password: "docotter", password_confirmation: "docotter"})}
    before(:each) {@student = Student.create({name: "Tony"})}
    before{@team.coaches << @coach}

    context ' vaild attributes' do
     subject {post :add_student, student: {secret_key: @student.secret_key}, id: @team.id}
      it 'should add the student to the team roster' do
        expect{subject}.to change(@team.students, :count).by(1)
      end
      
      it "should redirect to team page" do
        expect(subject).to redirect_to(team_path(@team))
      end
    end

    context 'valid for adding student with name' do
      subject {post :add_student, student: {secret_key: "Jessica"}, id: @team.id}
      it 'should check add student to the students and add them to the team students' do
        expect{subject}.to change(@team.students, :count).by(1)
      end

      it 'should change the student count' do
        expect{subject}.to change(Student, :count).by(1)
      end

      it "should redirect to team page" do
        expect(subject).to redirect_to(team_path(@team))
      end
    end

    context 'Already there' do
      before{@team.students << @student}
      subject {post :add_student, student: {secret_key: @student.secret_key}, id: @team.id}
      it "should not be valid if student is already in the list" do
        expect{subject}.to_not change(@team.students, :count)
      end
      
      it 'should re-render page' do
        expect(subject).to redirect_to(team_path(@team))
      end
    end

    context 'invalid attributes' do
      subject {post :add_student, student: {secret_key: ""}, id: @team.id}
      it "should not be valid if there is no student" do
        expect{subject}.to_not change(@team.students, :count)
      end

      it "should redirect to the team page" do
        expect(subject).to redirect_to(team_path(@team))
      end
    end
  end

  
  describe 'GET #remove_student' do
    before(:each) {@team = Team.create({name:"Otters", headcoach_id: coach.id})}
    before(:each) {@coach = Coach.create({name:"Tory", email: "tory@otter.com", password: "docotter", password_confirmation: "docotter"})}
    before(:each) {@student = Student.create({name: "Tony"})}
    before{@team.coaches << @coach}
    before{@team.students << @student}
      subject {get :remove_student, id: @team.id, student_id: @student.id}
    it 'should take the student off the team students list' do
      expect{subject}.to change(@team.students, :count).by(-1)
    end
  end

  
 end


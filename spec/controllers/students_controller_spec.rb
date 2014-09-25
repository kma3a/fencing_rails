require 'rails_helper'

RSpec.describe StudentsController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  
  before {sign_in headcoach}

  describe 'GET #new' do
    let(:student) {Student.create({name: 'Student Matt'})}
    it 'located requested @student' do
      get 'new'
      expect(assigns(:student)).to be_a_kind_of(Student)
    end

    it 'should be a new record' do
      get 'new'
      expect(assigns(:student)).to be_a_new(Student)
    end
   end

   describe 'Post #create' do
     context 'valid attributes' do
      subject { post :create, student: {name: "Student Matt"}}
       it 'should create a student' do
         expect{subject}.to change(Student, :count).by(1)
       end

       it 'redirects to headcoach page' do
         expect(subject).to redirect_to(student_path(Student.last.secret_key))
       end
     end

     context 'invalid attributes' do
       subject {post :create, student: {name: nil}}
       it 'should not create a student' do
        expect{subject}.to_not change(Student, :count)
       end

       it 'should redirect to new page' do
         expect(subject).to render_template("students/new")
       end
     end
   end

   describe 'GET #show' do
     let(:student) {Student.create({name: 'Student Matt'})}
     before(:each) {get :show, id: student.secret_key}
     it 'assigns the requested student' do
       expect(assigns(:student)).to eq(student)
     end

     it 'renders the show template' do
       expect(response).to render_template(:show)
     end
   end

   describe 'GET #edit' do
    let(:student) {Student.create({name: 'Student Matt'})}
    before(:each) {get :edit, id: student.secret_key}
    it 'assigns @student' do
      expect(assigns(:student)).to eq(student)
    end

    it 'renders the edit view' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    let(:student) {Student.create({name: 'Student Matt'})}
    context "valid attributes" do
      it 'should assign @team' do
        put :update, id: student.secret_key, student: {name: 'Matty'}
        expect(assigns(:student)).to eq(student)
      end

      it 'changes student attributes' do
        put :update, id: student.secret_key, student: {name: 'Matty'}
        student.reload
        expect(student.name).to eq("Matty")
      end

      it 're-renders the team page' do
        put :update, id: student.secret_key, student: {name: 'Matty'}
        expect(response).to redirect_to(headcoach_path(headcoach))
      end
    end

    context "invalid attributes" do
      it "will not change it for invalid attributes" do
        put :update, id: student.secret_key, student: {name: ''}
        expect(student.name).to eq("Student Matt")
      end
      
      it "re-renders the edit page" do
        put :update, id: student.secret_key, student: {name: ''}
        expect(response).to render_template(:edit)
      end
    end
        
  end 

end


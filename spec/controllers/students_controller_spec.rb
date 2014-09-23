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
         expect(subject).to redirect_to(student_path(Student.last))
       end
     end
   end

   describe 'GET #show' do
     let(:student) {Student.create({name: 'Student Matt'})}
     before(:each) {get :show, id: student.id}
     it 'assigns the requested student' do
       expect(assigns(:student)).to eq(student)
     end

     it 'renders the show template' do
       expect(response).to render_template(:show)
     end
   end

end


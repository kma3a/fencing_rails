require 'rails_helper'

RSpec.describe StudentsController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:student) {Student.create({name: 'Student Matt'})}
  
  before {sign_in headcoach}

  describe 'GET #new' do
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
         expect(subject).to redirect_to(headcoach_path(headcoach.id))
       end
     end
   end


end


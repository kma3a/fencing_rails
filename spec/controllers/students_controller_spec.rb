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


end


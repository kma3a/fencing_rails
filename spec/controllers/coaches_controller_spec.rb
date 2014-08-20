require 'rails_helper'

RSpec.describe CoachesController, :type => :controller do
  let(:coach) {Coach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

  before {sign_in coach}
  describe 'GET #show' do
    it 'renders a post' do
      get :show, id: coach 
      expect(assigns(:coach)).to eq coach
    end
  end
end

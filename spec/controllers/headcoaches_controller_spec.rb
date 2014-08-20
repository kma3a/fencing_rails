
require 'rails_helper'

RSpec.describe HeadcoachesController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}

  before {sign_in headcoach}
  describe 'GET #show' do
    it 'renders a headcoach' do
      get :show, id: headcoach 
      expect(assigns(:headcoach)).to eq headcoach
    end
  end
end

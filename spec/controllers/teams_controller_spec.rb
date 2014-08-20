require 'rails_helper'

describe TeamsController do
  describe '#create' do
  let(:params) {{name: 'Fighting Otters', headcoach_id: 1}}
  let(:team) {Team.new(params)}
  let(:action) {post :create, params}

  before do
    Post.should_recieve(:new).and_return(post)
  end

  context 'on success' do
    
    before do
      post.should_receive(:save).and_return(true)
    end

    it 'renders success' do
      action
      expect(responce).to be_success
    end

    it 'redirects' do
      action
      expect(responce).to be_redirected
    end

 end

 end



end

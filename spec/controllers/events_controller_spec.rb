require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  let(:headcoach) {Headcoach.create({name: 'matt', email: 'vanillabear@google.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
  let(:team) {Team.create({name: "Otters"})}

  before {sign_in headcoach}

  describe "GET #new" do
    it " locate the @event" do
      get 'new'
      expect(assigns(:event)).to be_a_kind_of(Event)
    end

    it "should be a new record" do
      get 'new'
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

end

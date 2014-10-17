require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Create events" do
    
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}
    let(:student1) {Student.new({name: "Kelly"})}
    let(:student2) {Student.new({name: "Sara"})}
    let(:student3) {Student.new({name: "Zack"})}
    let(:student4) {Student.new({name: "Ben"})}


    before{login_as(headcoach, scope: :headcoach)}
    before{headcoach.teams << team}
    before{team.students << student1}
    before{team.students << student3}
    before{team.students << student4}

    scenario "On the team page there should be a create event button" do
      visit(team_path(team))
      click_link("Create Event")
      expect(current_path).to eq(new_team_event_path(team))
    end

    scenario "On event page there should create event words" do
      visit(team_path(team))
      click_link("Create Event")
      expect(page).to have_content("Create Event")
    end

    scenario "fill in form" do
      visit(new_team_event_path(team))
      fill_in('event[event_title]', with: "10/02/14")
      page.all(:fillable_field, 'event[participants][]')[0].set(student1.secret_key)
      page.all(:fillable_field, 'event[participants][]')[1].set(student2.secret_key)
      page.all(:fillable_field, 'event[participants][]')[2].set(student3.secret_key)
      page.all(:fillable_field, 'event[participants][]')[3].set(student4.secret_key)
      click_button("Create Event")
      expect(current_path).to eq(team_event_path(team, Event.last))
    end
end

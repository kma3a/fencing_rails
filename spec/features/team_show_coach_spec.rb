require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!


feature "with coach" do
    let(:headcoach) {Headcoach.create({name: "matt", email: 'vanillabear@otters.com', password: 'otterpoop', password_confirmation: 'otterpoop'})}
    let(:team) {Team.create({name: "Otters", headcoach_id: headcoach.id})}
    let(:coach) {Coach.create({name: "Tory", email: "docotter@tory.com", password: "docotter", password_confirmation: "docotter"})}

    before{login_as(coach, scope: :coach)}
    before{headcoach.teams << team}
    before{team.coaches << coach}

    scenario "it should not display remove button for coaches" do
      visit(team_path(team.id))
      expect(page).to_not have_content("Remove")
    end

    scenario "it should not have the add coach info" do
      visit(team_path(team))
      expect(page).to_not have_content("enter coach's email")
    end

    scenario "it should not display the remove student finction" do
      visit(team_path(team))
      expect(page).to_not have_content("Remove Student")
    end

    scenario "it should not allow to enter in a student key" do
      visit(team_path(team))
      expect(page).to_not have_content("Enter Student Key")
    end
end


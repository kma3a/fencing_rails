class CreateTeamCoaches < ActiveRecord::Migration
  def change
    create_table :team_coaches do |t|
      t.integer :team_id
      t.integer :coach_id
      t.timestamps
    end
  end
end

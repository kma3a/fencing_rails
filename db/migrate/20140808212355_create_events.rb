class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :team_id
      t.integer :participant_count
      t.string  :event_title
      t.string  :secret_key
      t.timestamps
    end
  end
end

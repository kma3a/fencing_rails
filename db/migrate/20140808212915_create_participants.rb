class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :event_id
      t.integer :student_id
      t.integer :bout_number
      t.text    :bout_results
      t.integer :victories
      t.integer :touches_scored
      t.integer :touches_recieved
      t.integer :indicator
      t.integer :place
      t.timestamps
    end
  end
end

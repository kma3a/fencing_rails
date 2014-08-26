class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, default: nil
      t.integer :headcoach_id
      t.timestamps
    end
  end
end

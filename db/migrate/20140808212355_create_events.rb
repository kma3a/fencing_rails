class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :team_id
      t.string  :secret_key
      t.timestamps
    end
  end
end

class CreateHeadcoaches < ActiveRecord::Migration
  def change
    create_table :headcoaches do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.timestamps
    end
  end
end

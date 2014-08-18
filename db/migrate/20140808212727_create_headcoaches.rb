class CreateHeadcoaches < ActiveRecord::Migration
  def change
    create_table :headcoaches do |t|
      t.string :name, null:false, default: "Coach"
      t.string :email, null:false, default: ""
      t.string :encrypted_password, null:false, default: ""
      t.timestamps
    end
  end
end

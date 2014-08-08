class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :secret_key
      t.timestamps
    end
  end
end

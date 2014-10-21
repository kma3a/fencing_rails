class Setdefault < ActiveRecord::Migration
  def change
    change_column_default :participants, :victories, 0
  end
end

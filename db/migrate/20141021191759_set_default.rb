class SetDefault < ActiveRecord::Migration
  def change
    change_column_default :participants, :touches_scored, 0
    change_column_default :participants, :touches_recieved, 0
    change_column_default :participants, :indicator, 0
    change_column_default :participants, :place, 0
  end
end
